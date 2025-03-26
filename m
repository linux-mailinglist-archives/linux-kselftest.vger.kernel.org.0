Return-Path: <linux-kselftest+bounces-29821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA9DA71CE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E109C7A5015
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28081FECBC;
	Wed, 26 Mar 2025 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fhVsjeVi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C841FECB4
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009465; cv=none; b=Fnlaxn2eFmTJ4UwcprycYEjCkktk4fjZZ+ax3TjaZAEuKVWE3o7AOUupTZHZSfIqKGi2i6leCLVmdsKbpeZ6C5thgAsR0olphR799aKmwsUxOug66h0L8Fo+HJvAtfo3dxi2SdpH8hbmuK0bdwJDMVfGQ4dKo2QyLMuMVnkmgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009465; c=relaxed/simple;
	bh=R+Y80Fl4D3XILmrZi78H6SULsEtuP/szZHrz0dbbl68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REXh2irOTaDigdIYZMTJCf5Rss+vxqYEE+HPn3uIl0idOUASsKou+eh5Wg7MgNCCHbYTMTHG9Z9FKnFb9LezM86FCbz6QDIcLv+aKN8XIlVD3VkecwqVW/0n2m24QD+hGXeWNghkxDU+rvT/vIImgt4G1EpYR63RY+Uxdzx+K1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fhVsjeVi; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-22438c356c8so3353535ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743009463; x=1743614263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+Y80Fl4D3XILmrZi78H6SULsEtuP/szZHrz0dbbl68=;
        b=fhVsjeVibWxGja8i6E1jFRPaCSm4bGgFSNiUNeThA3L1bLPxDt80rWYj124SOQxXdE
         +ZPeLsz/6iE7/Q582xjwt15CSyFyVC2+mNN3nzn0w5e0qh36hDRM8sH+NEdrMg7/+IYL
         RuxmLAtfnfDc9c1TI9I5lap9ph4qnWSnloNypl/qcVPXrFH87Srx+ba7umPNF6TP+jv1
         ZSL8bhfdQ7KCcoKb3JO2o2KVY2alk8oB/QbU0M9VFezOUmk931gRRvfYY96x0C4vYKSw
         b4eoqOgNgTrwjkQ1Hj5c/O921TcarZjjQJZ+fmHK4oY7rKDxdba8gKFcKwphpBqxSHfm
         +vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009463; x=1743614263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+Y80Fl4D3XILmrZi78H6SULsEtuP/szZHrz0dbbl68=;
        b=ZVCIflWkkYkW4dehMMnEoXF3DT544hGzcOCMPIdrdbA1I3XEWyK0xanQB9Tvt/pDpJ
         XX6uLfqRSgsWnTKFDAC9CS7Bn6zEDcGH00sxzcqmu0TeTpj2xQlW7UqcT8/iIOmdGEGG
         R9K3Nbf8LrXku3XO5ncpI97dpy9ysDy1XQcv3eRaCLeebpGJZEf/FxJgDy2f79IeAfNA
         1wDH8FnuP3fZWbV4HXAxt//jyecd3Q7oG8ph9Yc8CgogikR2b4tzLdeWF5xD961o0ndr
         fBwW+6aUrANcY9FDd3pO2R/Cl2plX1bf6M+HSQTyI5M/5pRrdsbu6izasz4yLTQuau/Y
         0yjA==
X-Forwarded-Encrypted: i=1; AJvYcCWxw8QCeCa+pHpFGAyO0vZXRWsDKs68ITE8O2TUmgGxpGYKn4lOlcAR4HFFz7F9wwVV+EkJIGYtHaLasJvZmOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZgiOBC0IViDECIK9vehdS051i0hj5kQ0+CBuwRNXzts1++749
	cCWxy6IRWPgfm+v1RjOSc98PunpbLZZXkqD1qOfiXMduCKVCfO+vIYotpQRaTk8OPlzAyb8RvCc
	ol11JNCFNgaS58fJd2f9jk08w20JczRHi
X-Gm-Gg: ASbGncuxSfyMzgo4Nr6HVtkUbYevjMTDY7CKObZvhsvfMAqlxF34VMk9yuQrH8FN/xF
	Y/D+PzxprFOWAVcs+vdu9MGtAuco3ixQX2mlF4qt2R0qW7O8QabqrywvLOU7E+vzdr+r+FkPoEj
	74PqjAbQssCqEJ6M2tO9hnHzER8vFLo+CqY8/aKFa50zdZlJPTwKNO94KurEnjEhTU+kFSeuvAH
	PSHYH3tGW6PbQq0rYrhefs7ucEBkv3+6LbWodSMte9soc/yxthllTl8cXCf2xg0M3/RXGgfjxPj
	n22mDkY05cJU4mytDhDbsYkmsGb55wFO/RdrXqX9Qyns5W0a4Q==
X-Google-Smtp-Source: AGHT+IHLdUa435MD/UMv1YIUu9iHHEATcWU21t6cTQMIchpUDMRQTrioGjnCdfUWBnEqYE5PKTj4eW3k//Fg
X-Received: by 2002:a17:902:d54e:b0:216:7926:8d69 with SMTP id d9443c01a7336-2280491ddd1mr4238145ad.47.1743009463263;
        Wed, 26 Mar 2025 10:17:43 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22780f16a79sm5510215ad.47.2025.03.26.10.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:17:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 925D3340199;
	Wed, 26 Mar 2025 11:17:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 85EBBE40158; Wed, 26 Mar 2025 11:17:42 -0600 (MDT)
Date: Wed, 26 Mar 2025 11:17:42 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, g@purestorage.com
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests: ublk: kublk: ignore SIGCHLD
Message-ID: <Z+Q2tiQfZmh9+eSM@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-3-262f0121a7bd@purestorage.com>
 <Z-NzLbW0nAIAUdIN@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-NzLbW0nAIAUdIN@fedora>

On Wed, Mar 26, 2025 at 11:23:25AM +0800, Ming Lei wrote:
> BTW, the SIGCHLD signal is ignored by default

You're right, that's a good point, this change is actually a noop. I
think I got confused during test development and the -EINTR probably
came from something else. I see no issues when reverting this change in
my tests now, so I will drop it.


