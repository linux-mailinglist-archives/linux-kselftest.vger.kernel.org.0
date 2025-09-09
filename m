Return-Path: <linux-kselftest+bounces-41045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70A8B4A928
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 11:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4093627E0
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 09:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58E62D23A4;
	Tue,  9 Sep 2025 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=miraclelinux-com.20230601.gappssmtp.com header.i=@miraclelinux-com.20230601.gappssmtp.com header.b="DIMN1JAs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBA2D660A
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Sep 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411910; cv=none; b=TKNg4Icyr5OIMLob8qCHD3Ja8wWhlOBDrP643AazWqVOpZHsHraMHUEcMEI9ztSX2Jo6ekNpPsRHWwR9RrLc/V4o8E9HkjdrjlJVYF9pkGpVtUFqomUBZKEblYJJSr+bR7IQv9i0eZOwooSbcefy16qxVGFEAAXanJ/Md7LXziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411910; c=relaxed/simple;
	bh=BcPTgT4DaoNK+sqLNjn9V4T8XzfeAlyDj3xfj5ssbQ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ulc40o8p7sWk56IdTFAlnR4vCl+hX1Huv/dWuKiouavIqhAwLgx+VDS/hfdlKs+KmmLETwRdN9QL+aU+PAWgN0XLRjiihJqS+1ahUJHuGyeTDVijTN3ibkQF2Mj4+tNIp15tz+RShjg+UNrCa31RrUmKq/prS+kf9hns6XoFVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; dkim=pass (2048-bit key) header.d=miraclelinux-com.20230601.gappssmtp.com header.i=@miraclelinux-com.20230601.gappssmtp.com header.b=DIMN1JAs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32bb1132c11so3275543a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Sep 2025 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1757411908; x=1758016708; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BcPTgT4DaoNK+sqLNjn9V4T8XzfeAlyDj3xfj5ssbQ8=;
        b=DIMN1JAse1U/j1fqbaao3izdr1gD41+chyV1F124LiQ6zQr7Nv2KC3iRbcqu4QWe7I
         N+saklMxd1CMGoQSHZ2sQJBouHRtdx3FJQHGmHO+2mxfwSFcGJ63faVug9QC5MnRncWA
         ulRQeC+8334W9eFoxX41HUbLwHdrz8dpsmMvsohpTz9/xEkV2o0VXHr1VJ4XeTQ+DwpA
         30GYOujz6tlACU5BK1bmt+UkpN49UmnU0IBHBV4BOEcYu3iwL8mQWMAp7hnfFMOhAccY
         fhOc8UvG4cQDVdDpr2cs6oFv/3RmmupMf7zAklRgZl6faNpVpMZZrYq4eQp5K9kFn1hP
         J8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411908; x=1758016708;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcPTgT4DaoNK+sqLNjn9V4T8XzfeAlyDj3xfj5ssbQ8=;
        b=WW5xy8qHX4TYc19Z9edWZO9BPCZrDjlJ9aFF3RJU7CwOONPbvz3h4YJbmvQKUM9Ut9
         2zTkf/LwSH/j5SVR5RnvuJjNuRjXwE1U9Oyszzmo+2YjQerS22FVunhAp/gz0tqEj7GO
         1YkTi3WNwOW5oQR/q05j5vq5+sdic8x/laMuQTRY9ovAVFcCpcN4QOENOKJXFh01g2j0
         yvbJ/E8xzp0GIEIOgJRtgjNS9Tc2Y73CL0KpI6ajk/J88mavU4Wrg4RgdIGRhRjV6aYy
         6Tao2NsyTJcNgKp4VKVnVVcmKN1r1cfAsc39Py1sEvzVArrusHkpiJX0ut1U4y4EHV6S
         daQw==
X-Gm-Message-State: AOJu0YwzsFpEEzUKiovhqnw2+dICaTpkIl04feylJBBcnQBNnQRdRD7U
	2U2wzYDOOhuT919dAtGERJsYLJU9LohmHynExiYw3i/cWQti73M4fTyxQ3yzkz86IWYGld7bKc/
	JzyC4XgXIN/Wat8Z6TVfuHdvmJ+g+c/vbRZFIha+X/HeMH85A7QE=
X-Gm-Gg: ASbGncslkzPBtJL8jpnHjFXLmszRtc2RGmE4QyRTuEExtw5ZenJF9xDmneEoEtiU148
	4dW1pYKqnruWW4f0tRfkSNSixRZapN2ZANdrIRZr7KBo5KbAm6pjWF7dOnNLyUbyYo7QQ8tck8q
	fB5xBymLk7NfHWgvg1vPDJSZRAOE+lHO1AQg+PFVuNGl4VJXiUiz1uDwCq/ZYdOCAJ1/aTxaBld
	Ya1nXc=
X-Google-Smtp-Source: AGHT+IF1m2rO1lq8YsNb1JZtLnx7YFPnA47qj42l6x17TNVIDAy2/K7vf752ZAqr693wrJ0dJTpLhqHDZ0QSSmGW6t8=
X-Received: by 2002:a17:90b:2c8f:b0:327:53f0:6368 with SMTP id
 98e67ed59e1d1-32d45037a0emr11618836a91.2.1757411907905; Tue, 09 Sep 2025
 02:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Tue, 9 Sep 2025 18:57:51 +0900
X-Gm-Features: Ac12FXxcZ5tawe6vldEzR473P71-6XB_eXqZ2l7lI71wYP_rV2SpmrFPdLf5NAs
Message-ID: <CANgtXuMNY0KfdSJuHZh2khaGtNr8ic3hNGPkEG4mKw3p7YOhZg@mail.gmail.com>
Subject: [ANNOUNCE/CFP] Kernel Testing & Dependability Micro-conference at LPC
 Japan 2025 CFP postponed until 30th September
To: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shuah@kernel.org, gtucker@gtucker.io, sashal@kernel.org, 
	kernelci@lists.linux.dev, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

The Call For Proposal (CFP) for the Kernel Testing & Dependability
Micro-Conference at Linux Plumbers 2025 has been updated.
https://lpc.events/event/19/contributions/2001/

You still have time until the 30th September for sending your CFP:
https://lpc.events/event/19/abstracts/

Thanks,
Arisu & Guillaume & Shuah & Sasha

