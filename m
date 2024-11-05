Return-Path: <linux-kselftest+bounces-21423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4DD9BC1C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 01:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0DA1C21278
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 00:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302A279C2;
	Tue,  5 Nov 2024 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="twRx4sHI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B96ECC
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 00:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764901; cv=none; b=Nrej3KZ4BCcuYufMT5sP1xp1meRQ7gd59zmgzWF0tmjHzCnnjGQRqoJWTREasP+nU5cg4wTNJNefws2Uoecyn6kArmnA3ptcdjiNmh4zJAWmiLk6Y9+1fiqXFa6osr3nNUWW+bh8NI0N7RyMQT2X+enG5Ahqs+Hg6KV2P880aZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764901; c=relaxed/simple;
	bh=6yI6UEYCEKxnrx9+/HaTpOpIPo4ib88NscvinntE2CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgyHXHC5ToKQd1t/hl+gQCbadTHd6Svn36T483ANJKWhFDo8z6WFECXtfpoJ9xBUg/RTiIg/VVceOm+myVOEiZXQmEumPTrAhBNDfCHrpqS66QXoy2uLkUckWFKXizY/NLV08H2MaDP7WbMaxdeOLebaXVAXRexLU16aDYD/0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=twRx4sHI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e7086c231so4194844b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 16:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730764899; x=1731369699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiShwGNgjZXzIJw3EmcQvT2xIzvJnyyeh86E3dyA92s=;
        b=twRx4sHI0wz/woq772mlljvpYstU0YqJFG5KsNBnlET/7nJaLUOIRuKDQj5EPjk0yH
         22aMFWEJnGwsKYuI4wt11AYiej0byLAqDth0J4uUR0MpIWQxIXX0mAH6zOexcytI19ES
         j0HujcdW+rtt5/djCCNzP9N6fLNaMUdiNT9fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764899; x=1731369699;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiShwGNgjZXzIJw3EmcQvT2xIzvJnyyeh86E3dyA92s=;
        b=mRvxdfDlMQzNesNs2eGkt1IZD4cugJ9eKFCtIJsMBaOMDRPrKfnxy8YCPb1qvEV07H
         oK8Ql2SjCp1f1dLXSyy+T95ximrpQNM04+4t1cRYUWF40861caJwhaCzjhdkmFJfKXu/
         HcHS99m4j7FZcwJwdETXMsemIeJU3gFNp8zj1zIoDfVrGVYRxk8umzeIyfyylQ5awa3V
         26EvfoaZw81L78sJ9QBDiUI+m0NfWIPxA7eKhV9uNagbjwxlQgihaRoxMFIVdle9GNgG
         pIFFIE8a1zqtiGiawoodWQkxIEHf8ofaEivyqVW2LJRB5a8zmDNFCReUZftnptq8mypf
         jALQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJiZ4ncfa046vvsgWHC0U5mNY5HhtBhD0lm2yIQIkZCER+O8k4IAvvpGhdlb4BBSzJDG6Of72yAr9MJi3u8p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVNk3HHLPHNcsGqtAwkZ/QcaFZfGwycV8o/o4dfolNuJ63CyD2
	IhOVQnyJqVeHBxOrZg9OOi/r+1qrIwLH66Oyo5CT5tnGA9swRjEFYC/5ulvZQKg=
X-Google-Smtp-Source: AGHT+IHSdBpjRqV53YfC2PeU2ZEkln+b1qR+XerC9xeK/DFyQku0Yu13uWDphAHW0yUHzqmjnx+C+Q==
X-Received: by 2002:a05:6a21:1798:b0:1d9:3456:b799 with SMTP id adf61e73a8af0-1d9a8535d0cmr45172446637.46.1730764898939;
        Mon, 04 Nov 2024 16:01:38 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452aa17dsm7698879a12.34.2024.11.04.16.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 16:01:38 -0800 (PST)
Date: Mon, 4 Nov 2024 16:01:35 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 09/12] selftests: ncdevmem: Remove hard-coded
 queue numbers
Message-ID: <ZylgX5SzV_FExBJl@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-10-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-10-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:27AM -0800, Stanislav Fomichev wrote:
> Use single last queue of the device and probe it dynamically.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 40 ++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

