Return-Path: <linux-kselftest+bounces-48007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFACCE98DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 12:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB73D3021743
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888132E8B7C;
	Tue, 30 Dec 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ase3+yPC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EDB2D7D2E
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Dec 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767094624; cv=none; b=gPlEHlB74J6R+qcDNJnR9TTgfBZ6mE4PWjZYwgLMDJ9ozmLDYq7UhtaJS2zdnCS09tiqAYUWAmSoYzV9/GNW3oE1FweNYnZIssoJJBR8AKlm1txCpis5DuwDgIjRJUmjZjzzJXKrbHyc1P8yYPhmHpVCIjZctO63QB0yz+eS2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767094624; c=relaxed/simple;
	bh=8n8WP6t0YcDAYZ7kg3FzA+7B5fDmDzd8BrdVQJVpcRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZ04g0wut2oNGJPNCGGi+9C8VlOMtytkjofHLLjr9Grw0YbEER35lSUZCJMTcTu4GDtbKcdK3lObTC6WFNvD0mh8sghRyyd2ZvdK3uiXslEyQtFnAbvzJ4QyQxRgRxQddD+kjKuPXXK2o3Me8/2GmazjhYNuEIgqbFSVRC4x2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ase3+yPC; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37b99da107cso91667681fa.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Dec 2025 03:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767094621; x=1767699421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CmAFwrYbDuyMoa/BPWjtX3r2mUHX5vgd3DvqkBcFzk=;
        b=Ase3+yPCgI2K/7zwY6HeHLVpt0MTzbeVu+fQe7YltTVnJsipj/+VnLDpzD9gUutvUE
         If0ARIlIQGQPtaxrMb5538uWv0vFWABUlrI/mtJLxGZy4DvW8RWGyi7onFwFQr+cpvGX
         5NQDZscrk7FIL3gtbRloK+ymD9Xiqdt//Of/zWl2Si6mcZmb+PTaEeXsdJOVlRzAHcCr
         bIsjN8Q/NPw6xueIx78sUHN516LUBT5PqD1MJYcFCpBI5pWJHsdffSO64jdjQ36dEQ8/
         DQ8am0zxmUmpmW2MztQ3a4z8f/wd84yf6AG53B3pXgQG65hnO6W0ih3eFgeIk31sSLE0
         AH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767094621; x=1767699421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4CmAFwrYbDuyMoa/BPWjtX3r2mUHX5vgd3DvqkBcFzk=;
        b=bew3T/NMHYtY969HrzCkG+ziYrUKb7+ZEWnwSf/1iTAGp6Z9OohkiTAS9eZjMURg/f
         bK71bBDlol4yOdoYuzNAS6s57KWkb0rmScarUeBxnaU2wCj7WarL4A4WchymUHnrhuL+
         y3HJAoyOKBffbtzagosibeJn3PnnM6Ao70+lRtzyQjS6nUSQZpJwula8S6VCUHBk8V3+
         S/5lyAg3xJ2jEuwv56h++ENkvNY5NhhUalIaALmWId4BLOT6IL7LGkJIeQmXcM92q5O1
         ykmNClPv4LSHJN+eia7VRUjs57Et53e4ROIVQgQY4UQ/bMIyR/gxqDG+ZoeEX0M/rb6x
         NIQg==
X-Forwarded-Encrypted: i=1; AJvYcCXFiByEC8rYiIN7h5lOWzw0hbCfFEylzu1Udz13ce+SWfW3tx7GVHsdzXdySypuZ6ovbHg3Qd7xqtxexpfWz14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1xcqrdHMKv/ZoOpA6fCmFeWwpYt/BLLryP44zYbKgCdBuvj+T
	plwKGz5Evfm4/Qy+Ik8nVEigMOyUlxd3mU9cxWzUbwftw2IQjsq/Z1SV
X-Gm-Gg: AY/fxX6rcwckiZQUPlWAUZl7BVsd0D3Eg+g6zRlwLn6IFxGNwfquhW4VlbCked9THe5
	JImWUcSVUEIKxy1PJqqC+pqIc60xVSS3TFOP6t16XuVk0XH8ltECmkPQrUu0a6cQK0kqPd1/X8R
	0WG3G6cRHCAilfyKysO3fgPAfShI6on8pNsPgTbWYTYpI1rrMM4Yi2M8QB50879XQy10c04GX+x
	TlUhtnI5QC4YcwRm/1GjiBU2tSXxVTBDoeT7XR9bRhjnVPxw4vN4XD6f7e4nqOheZ/JoW+VRlTL
	FR/JvTIk/HeUrjMEXohqYUvEJwiy4iMJwTgLoLbLBhLLtP5sed1ohZ1Jdu0keeBhXITcmy00iX1
	xtE+lv38eZg15MsX0bTrqHNbuFFo+tytN4JX9n9+/A5Ka4mzT/she6Umpud++DHsMq/PB7LilBh
	1Kp+yeOT/K
X-Google-Smtp-Source: AGHT+IGF3gFGUozf4G9zt9Om+vstcNbw0h6yAp0aZ++ChCDii30yTV/4I9FiaTW4YuEjPjrGwT/sFw==
X-Received: by 2002:a05:651c:f02:b0:37f:8bb4:88 with SMTP id 38308e7fff4ca-381216bd8cfmr102647771fa.41.1767094620457;
        Tue, 30 Dec 2025 03:37:00 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-381224de728sm89285781fa.5.2025.12.30.03.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 03:37:00 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: nfraprado@collabora.com
Cc: Tim.Bird@sony.com,
	bhelgaas@google.com,
	dan.carpenter@linaro.org,
	davidgow@google.com,
	devicetree@vger.kernel.org,
	dianders@chromium.org,
	gregkh@linuxfoundation.org,
	groeck@chromium.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	robh+dt@kernel.org,
	saravanak@google.com,
	shuah@kernel.org
Subject: Re: [PATCH v4 3/3] kselftest: devices: Add sample board file for XPS 13 9300
Date: Tue, 30 Dec 2025 14:36:16 +0300
Message-ID: <20251230113655.1817727-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <78b4f1f60563fc854f5f4a54b42e0bac60715070.camel@collabora.com>
References: <78b4f1f60563fc854f5f4a54b42e0bac60715070.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

"Nícolas F. R. A. Prado" <nfraprado@collabora.com>:
> While I understand it might be inconvenient that this is the only file

As well as I understand, it is intended that more files will be added
to tools/testing/selftests/devices/boards with various vendor names and
product names.

So I did some further research. I grepped Linux source and found some
vendor names and product names with undesirable chars.

Let's go.

/rbt/linux/arch/x86/kernel/apm_32.c:2097:                       DMI_MATCH(DMI_PRODUCT_NAME, "PC-PJ/AX"),
/rbt/linux/arch/x86/kernel/reboot.c:396:                        DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 300/"),
/rbt/linux/drivers/platform/x86/samsung-laptop.c:1633:          DMI_MATCH(DMI_PRODUCT_NAME, "R40/R41"),

Here we see / chars, which are simply forbidden in Linux filesystems.

I also found a lot of others undesirable chars, such as "(" ")" "'" "&" "#" "*",
which surely will break a lot of tools. In particular, "'" is used in bash
to quote something verbatim.

Here is extended result of my research:
https://zerobin.net/?d1f2655a979acd3f#oBhwIedQvBL/iB9Src65aRYuyjaye2GQBNL3+6yfvGg=

Unfortunately, I'm not sure which of these names refer to whole "board",
and which of them refer to merely some particular device, such as USB device.

BUT for 3 instances of / chars given in the top of this email I'm totally
sure that they refer to whole "boards", so we have at least 3 totally
legitime cases, where we have / in product name, which simply cannot appear
in UNIX filesystem at all.

So, conclusion: if it is indeed intended that further examples of boards
will be added to tools/testing/selftests/devices/boards, then they
will contain all sorts of undesirable chars and notably "/", which cannot
appear in filename at all.

For all these reasons I ask you to change name convention for this directory.
For example, use some kind of sanitized vendor/product names.

> there are
> tons of dt-binding filenames containing commas in the tree.

Okay, I agree with this point. There already are a lot of files with commas.
But I still don't like spaces and all sorts of characters, which are present
in DMI vendor names and product names ( "(" ")" "'" "&" "#" "*" "/" ).

-- 
Askar Safin

