Return-Path: <linux-kselftest+bounces-15730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79B957857
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 01:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E402826B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 23:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0141DF66B;
	Mon, 19 Aug 2024 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aui2BYl1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383401DD384
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108774; cv=none; b=H4DjPAXRbWEMO1csrtyrtr4vD1OYnYVaY35TL5Rotr2jsb3M3aGyuSwzrjmPEiEP4tnuxfyXLpgbb0nSTOaLw4oxqa1Sc7PqjuPl91eWyAqO3pIVYO3q14ddoOXJei7mbDvGylYafgkX5CjwY/Rdg752C/ahImCkso2zGWHlU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108774; c=relaxed/simple;
	bh=plHoBq5KbfGDrv6dOpY2JUmRVsjTfFCvCQ7zjz1FPA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKzMLm2SWUIupMT7XWmG/A4hHckx12JNVHtyHsXj8XTSSrh2KyiDv65W56wScn9JYm+beDpCgK4BtNOxa52gsbgnGwNo//T7k6C8SWBuLnMCttcv50PsGggW3W1JQiZ5Kvg+pRBW/rgIylF7RhvFqo4fIe9s9eo8o/uDlO/yMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aui2BYl1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2025031eb60so10280855ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 16:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724108772; x=1724713572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAaL9iLsfBr3KmkxqVCqI8crZ4M3zG1jsxZQrqUkREk=;
        b=aui2BYl1aj8YYCiB4MqU1nHrhx93VNi75/CYifUHELD16PiF6ZujbJKr2+ZSM/48mT
         mANpYzjr4o1RMCXhNbWfYwHLA14VfFj4ildMSZGusD7NtIVoGQUxEJddVbRqLrgsMfph
         EizrUYVSV6WI/+TcPhNxLy+a1SA/59PuVIYguOT7ExdO2GyVjDuabHWCfuoFhK5qLM2F
         CQSc78yNJ2sMOfWTwsSFxVB5dOB2r3R2X/D0xVNI1kmjczjTrnxRk4HZXsRYK77dEzh2
         CFfgWk4BPm3xiSmR2BWGL+owhSGV96WDXJNqZHPe2Hzs3tyNRqHkYySMAk84MHlyvSo0
         nMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724108772; x=1724713572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAaL9iLsfBr3KmkxqVCqI8crZ4M3zG1jsxZQrqUkREk=;
        b=FZWKpks8cCOgfgrpHUn+Z8W/GuDflBG2yUGpNfpNMmedGUz9cLYs+6UgL8BRqtu7Vn
         6+H26dlRiiv/twSf/qQMgwoRn7WVnmahYxKsjuXGIWS3IenvKAzAssu6znLig5OKYaXt
         DFCYf+RCPpyy+WlNXqEN7zZRBNP9k7lDungns8lLacEp/5oIxVMa7GjWZTQLGquDl8k1
         rBuRWyUXtHqz4vUuc4Hk7kh+dCpbWxcS9VmrsV1jG9DSOjs/8sK4xTwMxOl2Cr3unXhe
         eE0wikx6DYk+TGgHr88vMfXjztX3mEUhbDmeC6CormF7+AcNUlBbe8srM6vEFMmKGqtB
         DRWg==
X-Forwarded-Encrypted: i=1; AJvYcCUFj/9rgUgbXZDxjW/vbGwFwvMzC7ki7olh+vNYz+ut5JCigkGsVKomm1XF4fVdyTVG1Lf6QqlbwU/738aQI2kNEfSBWOtUFVZB2XhhO7Hc
X-Gm-Message-State: AOJu0YyxMcZHhBm3xUXBRKCfCfmZuru+Vka9PAKTasN6Tki31n2dnrEl
	SgJNvFGsS7p8DoJsP5ioTakmF7yVgXbtAHUm4sLYAmhfTr5WKkbFPKjeg8FzAXU=
X-Google-Smtp-Source: AGHT+IHBfVyuiRiWWmeZGAb3eMUhDH5U34j0O0Tsptrx7dedS32uu6dqmeIX1/j/vghFFG3MWZ8Y4w==
X-Received: by 2002:a17:902:da84:b0:201:fac8:ff68 with SMTP id d9443c01a7336-2031517e5bcmr5848595ad.50.1724108772271;
        Mon, 19 Aug 2024 16:06:12 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037592csm67028215ad.142.2024.08.19.16.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 16:06:11 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:06:08 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v9 00/13] riscv: Add support for xtheadvector
Message-ID: <ZsPP4GMwPVBfq+fL@ghost>
References: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
 <20240809-slapping-graph-461287bac506@spud>
 <ZrqsqsCtKwfG4Q5B@ghost>
 <20240813-strode-revival-07b8556a8bfe@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-strode-revival-07b8556a8bfe@spud>

On Tue, Aug 13, 2024 at 04:55:27PM +0100, Conor Dooley wrote:
> On Mon, Aug 12, 2024 at 05:45:30PM -0700, Charlie Jenkins wrote:
> > On Fri, Aug 09, 2024 at 11:31:15PM +0100, Conor Dooley wrote:
> > > On Tue, Aug 06, 2024 at 05:31:36PM -0700, Charlie Jenkins wrote:
> > > > xtheadvector is a custom extension that is based upon riscv vector
> > > > version 0.7.1 [1]. All of the vector routines have been modified to
> > > > support this alternative vector version based upon whether xtheadvector
> > > > was determined to be supported at boot.
> > > > 
> > > > vlenb is not supported on the existing xtheadvector hardware, so a
> > > > devicetree property thead,vlenb is added to provide the vlenb to Linux.
> > > > 
> > > > There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 that is
> > > > used to request which thead vendor extensions are supported on the
> > > > current platform. This allows future vendors to allocate hwprobe keys
> > > > for their vendor.
> > > > 
> > > > Support for xtheadvector is also added to the vector kselftests.
> > > 
> > > So uh, since noone seems to have brought it up, in the light of the issues
> > > with thead's vector implementation, (https://ghostwriteattack.com/) do we
> > > want to enable it at all?
> > 
> > I can make it clear in the kconfig that xtheadvector is succeptible to
> > this attack and that it should be enabled with caution. I think we
> > should let people that understand the risk to enable it.
> 
> I think the clearest way might be "depends on BROKEN"?

Sorry for the delay, I am not sure if BROKEN is the best way of doing
this. There is the generic CPU_MITIGATIONS config that I think we should
use to handle this at boot time. This would allow generic kernels to be
used on the platform, but a kernel config of "mitigations=off" would
allow xtheadvector to be enabled. I'll look into this a bit more and
send out a patch. Palmer merged a patch into for-next to enable
GENERIC_CPU_VULNERABILITIES for riscv so I will add ghostwrite there
as well.

- Charlie


