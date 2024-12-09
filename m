Return-Path: <linux-kselftest+bounces-23014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5BC9E9045
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5156518867F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20B217732;
	Mon,  9 Dec 2024 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IxP4kqr+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1A21771F
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740429; cv=none; b=jF5VsP+oteD4rlaGEAQTWQRUR4XnCWb1sPYTK1XfPIerL9vHq9IhX9Uxelde7mc8qYtUk3BjPOtaw7Ish+Eja0I+HZXsSZ098ogVcZmQQbtBIAp5ZG35jtnBDQykHUDfdoUFy9KZsNsTa58hqTo+57i+zQhm5sAZTAyjdGmQemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740429; c=relaxed/simple;
	bh=hGUNkPAiGXqDSa7dT0mfVI5e/Of5hnaQwknDb+vS7nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/1XN1ySREaef4zY5zCDPY9PKYX21uy0UT7RiGfcyWFhVUw5239vbIMvHJ28lTRpXNtKvqLgDnBeWYG27/6q8urywTcPCHKG9aUsd9H7VrMqQlmGRK2jZ9ltb7OY3CD0o9wVBRcE6wqAlZYDfSp5rMzyxk0M6czB+K7QTfxUUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IxP4kqr+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385dece873cso1902341f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 02:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733740425; x=1734345225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aO4nLx0kfH9s6VR/jADGyHU7Uf5zkyJtN7uAkPweYn0=;
        b=IxP4kqr+knA05dewRXP352kR4vz/uQ92QRo0hjAZcwY6Y0gVSMdurW97o38J7nKz7x
         sVmGTnbJgJCL5EZhQHePfzk0FmfRzA8pEcGwnyxWzLxqoIEN0MGTK4EFJ+lu3M6EgKDn
         +YHRvl5Xq2btDL4J1H6QiFIV77EVTcWqM94lqaZ6OQav49EZ3i8Y3ni3KQfsMQGG0p9v
         PL5GtCTrAW3ayTmJzpOF7EVnGGJyYt959kzDkMyRmWiymAi1ErFh2Wcqd6p/ezwvgxFh
         MYwFy0JqAaldsCThAOlCoAsRzWCZNpbR43nsMSl+IuszkN9jZ/pCrV2Cb+Seyu5HSTBG
         A3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733740425; x=1734345225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO4nLx0kfH9s6VR/jADGyHU7Uf5zkyJtN7uAkPweYn0=;
        b=ecMOI0TEU9JOps8yoi0ldNWPOmMzXScvqTKjO4FSmfls6tCzRBMXpd5eXTTZrmQCU1
         J7+BbCpeU9RhQC2NXssiAjJ34frH82ecwUeHbgTsXEHHmq6/fLSrhklYaBG9R0ACJATE
         0LSFzSfEk5qjfyijOapnIz67B3oMtB6MKY1C4sxqDwCKj2awLSmvar+KHjUWMwDVM05C
         iEUHwDgrQ13PmY/Q3lXfm1Vrc/T+FIFzOIN5vXJnrmAjLGRf6SUM03h6EaGaOCevR7Eh
         O3x53iInWk4n8/9D5fSLNgBSQcucKgIQqwiv9YL4NpiMPlCq07HVPJfb7tVs4xxb2QY0
         z5bg==
X-Forwarded-Encrypted: i=1; AJvYcCVv0GxpjoDIBdd0YjusSLsPYjfokLAZxvdTmtPeof5aqOEeVmFm+8Yf/HJQiOKTRRM1mw9dshX+Xm7vQPBaGZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwGrJxvzrO6alq0TffOwB6i5dT2E+rXC4zsBoW22yVLUR1JE1
	Flmx15tDZ54YaZeMJk6shdhK5Phe+f4STYh6Fsfj7LwsJIervebfnC9zQTo3Dr8=
X-Gm-Gg: ASbGncud/N5mBYNom7P/uXGhW+PxMnDKV7138/cyjSy38QTi2aCZ7GT6MEwcUdhjwbB
	Bc+XDrWD7cEdhpc8yNJ0zPrXUBEENVUl1vQXQXPWCYu3L58WQfdcv5XV+mIVwDQI8FqkKzpgaon
	vrbNTrZqXCOevt4ir3yaL5aSn/9HGmkorXSNlUUjH2EQcY5+155IDhAV0E/1Ol18+SMWUE/T/qU
	EZQqgC+9BjDv+sW6FZm89mpns1t0zM4io115vg0r/HqCLKhRZs=
X-Google-Smtp-Source: AGHT+IE1Mq2p1wEAoDyK2ADS8QG2njkoPsV/DcaIyc6/bJSThV8qrxTzCj1DyCksy6aEjoZIpmshjw==
X-Received: by 2002:a5d:64ab:0:b0:385:f17b:de54 with SMTP id ffacd0b85a97d-3862b33f3d0mr9798912f8f.5.1733740425377;
        Mon, 09 Dec 2024 02:33:45 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f3e936ffsm919093b3a.132.2024.12.09.02.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:33:44 -0800 (PST)
Date: Mon, 9 Dec 2024 11:33:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH livepatch/master v1 2/2] selftests/livepatch: Replace
 hardcoded module name with variable in test-callbacks.sh
Message-ID: <Z1bHgHlMuc_H3L5R@pathway.suse.cz>
References: <20241125112812.281018-1-dongtai.guo@linux.dev>
 <20241125112812.281018-2-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125112812.281018-2-dongtai.guo@linux.dev>

On Mon 2024-11-25 19:28:12, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Replaced the hardcoded module name test_klp_callbacks_demo in the
> pre_patch_callback log message with the variable $MOD_LIVEPATCH.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

JFYI, this patch has been committed into livepatching.git,
branch for-6.14/selftests-trivial.

Best Regards,
Petr

