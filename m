Return-Path: <linux-kselftest+bounces-19214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A376E993FA7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA441F240E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D41DE4D9;
	Tue,  8 Oct 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQI8ddha"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E038DF2;
	Tue,  8 Oct 2024 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372574; cv=none; b=mjhCEkPbDM4SZprlP9jP3qvTDv6ZdWBcCPZMyjTKbvGF29l3AE9lISGjrUW0OtcTEfGlnyUSlK85gy/vD1OvcfGTDvKSdhVcDxyLfqU6eBCQq0wJWpAtiKU08hkhTWdAeg5R8GRMe38Hmd7gOzUXJjKJe6OvWOLSvI7SxJyOHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372574; c=relaxed/simple;
	bh=sWwoswzShb90vRQbYwf+kBU9ssWTnnfs6VbJuucqszU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+X/HNtlRdKWtBtYBGIyabN5whI0fCgHfVpeHszef4syjeEmqrmd3kI3NaIMznCJK5ErnaFPHSazTZN11sv95qa/dmoCD4oZP+f19x2KN6M6ebX8EgJnSs7vRUD8adVSh539TH6gsW1/NbCMu5lvbF6if/5yk8mPvoIm6D4/WWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQI8ddha; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71dfc1124cdso1692271b3a.1;
        Tue, 08 Oct 2024 00:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728372572; x=1728977372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3a1cAhE6rVCNLuQTUGnxvuOkYxQX0P3Qps/w4gfQYAQ=;
        b=VQI8ddhapZj4ecIQNSD1j5FC1lbcT313afLMyYgAUsN8xqmUQT8uWY1nHJAohZ17bG
         sPAf2spN9Nr89C107sAJVGVfBUHbhJOw/82U9yWcEvMn5V/z64bBon3/OAEtRmalQkeB
         2S/4wIN5AW9LxJOPbOuKrjnwLyGZXM0R8b8qBSEM7xs0ohN6+TuobwuX1geRZHkF6NZy
         /9gYnfk+BqIEB8uheX41EhVEx1d70nvfGae2ot/DnbRDDSFU+HVy/efGF+RaSVF4yk3K
         7iYM2ORu4RvOG52NFqOMzjfS88ko93IzF5WU3hKGh3TRqtDEtkkDONEyBsMEPDICM1p8
         vVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372572; x=1728977372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3a1cAhE6rVCNLuQTUGnxvuOkYxQX0P3Qps/w4gfQYAQ=;
        b=Mp0ZOqGZ0Qsi6CZoTEtA/4G32PeZUxzgDScWhrQdmn7oV8czcvi3xa7sHMEE3xQC/+
         Gv1MHzpyIbqFfEzKhXfM7RdpesGzpbbGvQ8KpCfRamB4TwFA4HrK7oowRUPOf33GN1Vc
         yi+jMktAPpaY14hRaIX5qeq+ER6iN8lMlDkOQefhb9MJCeXdZz1K7KYj07ADxzkTSdfZ
         P2H7jzcEULBtabjWlOcFHEVWh+QmaOt9fJIn18Mmyyv4YTjyGJ/Re/59JtidcPqmTXaw
         2MlKmMOniME1ijJ4nTLi5GOJGjUysxdXjxJEgkCQj+jYxfII2HxsgFU8IvSyH7KzYlFd
         OcoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoK48Bu5bGh95gS7eTIzqp2cnEcXLgQXgd7jLRQ9/pUpFJ2zReQLa3VpkTJUOc1O/vzJVxdKQPwoXnt1ZeHikJ@vger.kernel.org, AJvYcCX65i/HzktftO2CWVzME4ZH011qzdBwk4+l+Zs+IA5beNZhz8xzkh2+hvEpKI/aVQz6ImsNihZI1PHZyT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65uen9lJ8QXhxzcDGzaW53lCALEc1VPhxNmMiktPCO4+On+tA
	eylaaQ5hwcc6DqCrh/UkMT4drbihkONoODGT8Qig5qfS4cGBU2Ll
X-Google-Smtp-Source: AGHT+IFaQ1xcVVP7Gz7ZD4yGrp0hZUbkaktD+9ZZCz7YHbxS8ZrIutX4Ssr9NvcXcN42nKlu/0YCLw==
X-Received: by 2002:a05:6a00:2e06:b0:71e:d7:378a with SMTP id d2e1a72fcca58-71e104ffb60mr4019893b3a.11.1728372571805;
        Tue, 08 Oct 2024 00:29:31 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f680c9b4sm6030425a12.15.2024.10.08.00.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:29:31 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:29:28 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: davidgow@google.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: [RESEND PATCH v4] list: test: Check the size of every lists for
 list_cut_position*()
Message-ID: <ZwTfWH6E3jtfBXqF@visitorckw-System-Product-Name>
References: <20241008065123.26422-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008065123.26422-1-richard120310@gmail.com>

Hi I Hsin,

On Tue, Oct 08, 2024 at 02:51:23PM +0800, I Hsin Cheng wrote:
> Check the total number of elements in both resultant lists are correct
> within list_cut_position*(). Previously, only the first list's size was
> checked. wo additional elements in the second list would not have been
> caught.
> 
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
> change in v4:
> 	Amend the description of commit message, make it less confusing
> 	and focus on the correct check which is performed now.
>
Generally, we don't add the prefix "RESEND" to the subject line of the
next version of a patch. "RESEND" is only used for resubmissions of a
patch that hasn't been modified in any way from the previous submission.

See: https://www.kernel.org/doc/html/v6.11/process/submitting-patches.html#don-t-get-discouraged-or-impatient

Regards,
Kuan-Wei

