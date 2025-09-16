Return-Path: <linux-kselftest+bounces-41570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9884B58EBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 09:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72199481825
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 07:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8982E11B0;
	Tue, 16 Sep 2025 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1Qbdimi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22DF2DFA31
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006346; cv=none; b=QFXo1Cix6YJiAw6ZwccNATmCpMIvY7NH6E3JyDZoEjdaaycrcdJGLWW8ejs7/jF2hi115DPAKKGglBvcYpxgyJwlH7nEYfOsI01MUqfSv6yR3M3lzzEmvqh/soQhtw4mEEg62nWYLILqFAOUAoKGxkt3TNSAEqPFy/Re9MAaHm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006346; c=relaxed/simple;
	bh=TNIQKUvJRB04Q1hRIuEOjVnqF1w3pSVsIj/B45tXYOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPhk8TQCKlH/cL6Uy1+fOPnqwUsArM+r72UAfPGbR+FiSnGykwGjWgz1cKUB+K2w3A6DVYIHkUrB6WMx6v3x5oRjRj2edQKzQOVxejbS5wcDBSPFIweEJfPfQAZpQSgDBdMVBwC9+Mhc0snnefWBo1oyI2IqXRzIIAeskDj52IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1Qbdimi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758006343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhPkfwNpOOrLEzdfCrUe596HJ61Ztd+hGAvFe0bAqJ4=;
	b=g1QbdimiL5gXjmkKacwA7mm2ZsJShsVeYo7EHiHSB59vBsE0dkddVJNwdFczWj2Sa3prbB
	2rnD7pbydQswUMBNWmCyjcrzsYaOQHVtKGG4XKXbcRHJhCekp8GSkXz/1tkS+UpNnMY43o
	wb0JjJZntp9aUmpR++xuDIKDPa415qk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-4eAgo__0NZaAsbKMH2b_cQ-1; Tue, 16 Sep 2025 03:05:40 -0400
X-MC-Unique: 4eAgo__0NZaAsbKMH2b_cQ-1
X-Mimecast-MFC-AGG-ID: 4eAgo__0NZaAsbKMH2b_cQ_1758006339
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e8c4aa37bbso792294f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 00:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758006339; x=1758611139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhPkfwNpOOrLEzdfCrUe596HJ61Ztd+hGAvFe0bAqJ4=;
        b=SF+SRKU1X8ajhxBHEiI0HQkG+6kl28yZa0pOfSg1JEiALxHUT+NuIs670EhqNAwX35
         R7Voo9+RA3Ag7TGDG/SBltA0OFOBBbibGIo7CvWZT1rZeqWlEa4pRsUTD3I/hZcZPusF
         62BrckjCFCrudf8GQElnkUu3yO/dymDivh13hfVcYrFaBEl/1kecWSe2evfDHfwcbN1J
         IDqcD+J0sVUnoAZ5mckrsAPcHVSFea+igFuIqcOX4o23uGWU9MOw1GZa3E8w+djPO3iY
         XP0Z920dYp40wUeCQykUP8WOWKkbwwM61Wec0lZKsGIZH66LX1HAfu/Ss/UjL4UdIRes
         JJng==
X-Forwarded-Encrypted: i=1; AJvYcCX4JqdeZAiIRPjsxmjNTGA7rRMRYaVFqmWdb+JktTfABxxZAAaFp/GYpE1DMMSMrYDZkYysfDd6k9M7EgU4oYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+Abh1hpnIXTGfgVEZ+sYzJnCGplpSdNbwFr4RJVRKbv/egaZ
	K/yuFR7KVJ2rree3HsRkkQB42hAaEogoIcCm+VGu/0UHqlhYXewIzaRxjpFY3hvdRhazgG0JhL8
	rhP5KcjNJTWfb4HD/LF/ZMCKD+iiVsvvfTZ1ReOsadC1AJ6XP5Q+tLqGVs6/mn2r8BYsVqg==
X-Gm-Gg: ASbGncuJfJ+Z9O52UNBKdSjT/UioBBuRezbF0sYpSVTV+gBM172/NZBkjWYEg10/qry
	tJ8UXtITc3hAKqKTgt0A5vbR/fYmWPjy1Ly3WKURHRsU8g2KqTo05BQqQZ/mmOB3gwZvIkvkPWP
	raYwof59egtkXHa6vfjWsCRX9p3MQKOF8ITcTOBhHNzaVSH8A+VHhEpv8bTeiXjLp4nYxbVOxmn
	1p6uzaZR0kjIo60pUhwZIAqq7vLUe4xweuvE9sPYmr1PNHd9udhpaMcLMlmJJWuoT0RM0WO5C5h
	69Dn2L66HJzBrQdr8dHRD1nx72wc9wvGT/R1O18rv3YhfgJJIZ0oQOdEVsAjyjnqdoZfsNsrPZq
	8Yh6qsPDWovgW
X-Received: by 2002:a05:6000:3113:b0:3d8:e1de:7e4f with SMTP id ffacd0b85a97d-3e7657ba3b7mr14614224f8f.21.1758006339357;
        Tue, 16 Sep 2025 00:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn11P3XuahtQkjvx7j6cbCjlqBM8n9q7Ge8AeRpF9xn7jo1jWEMb78D9FAVMCz+FeSjsl3Qw==
X-Received: by 2002:a05:6000:3113:b0:3d8:e1de:7e4f with SMTP id ffacd0b85a97d-3e7657ba3b7mr14614189f8f.21.1758006338944;
        Tue, 16 Sep 2025 00:05:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d7595sm205427615e9.24.2025.09.16.00.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 00:05:38 -0700 (PDT)
Message-ID: <a3721ff5-9e64-4a9a-a207-d53af7f8a10a@redhat.com>
Date: Tue, 16 Sep 2025 09:05:36 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 2/2] selftests: bonding: add vlan over bond testing
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20250910031946.400430-1-liuhangbin@gmail.com>
 <20250910031946.400430-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250910031946.400430-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 5:19 AM, Hangbin Liu wrote:
> Add a vlan over bond testing to make sure arp/ns target works.
> Also change all the configs to mudules.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Does not apply cleanly anymore on top of
71379e1c95af2c57567fcac24184c94cb7de4cd6,

Please rebase and resent, thanks!

Paolo


