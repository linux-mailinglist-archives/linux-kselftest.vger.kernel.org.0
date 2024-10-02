Return-Path: <linux-kselftest+bounces-18866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 342B898CF60
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9D21F22C31
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FD2197545;
	Wed,  2 Oct 2024 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xyqtqx/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B56B15445D;
	Wed,  2 Oct 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859633; cv=none; b=kdRjiw0q01+lwE4oUM2r8OLppeXj+cBRX+VMCDqipiQZnus1wYKv4k6vcho339vwjPZt+kPQOXg1k4PMIkqTVjcdStA60YvbKBPkY+gVurJhN476GGQEVdppJge9Chv97qJ8e1PGbiZ50dZc6fe2JNPjDR26iqp3APBxrr2kDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859633; c=relaxed/simple;
	bh=MKz3WBfXzE5naVWCAxgWzoONfkxOoznXhEQByYRmG08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkrAaCf8ORPO+CVqKenwQVqql/Io9QRVb7uPvSGfwU5PB4lxm/siTyibcVFefFnrgAYJvRl3wvl61dJM/SX7BWmzibjX5JpI80ouUAmNAWh6fsPEPrfalyInmD4GsoMLImdWU25NkCexzvKdTXCCdnAPqmC+xuOmMDk6eG8XGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xyqtqx/b; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c88e4a7c53so4572744a12.0;
        Wed, 02 Oct 2024 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727859630; x=1728464430; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fFYM8qk7RMOhwLcJ3G76fKAhgJmVj5Stu3SvCZ6kpWA=;
        b=Xyqtqx/bZqW5nNRU/+rg0NYYmzRVRtEK6fCnvxODGkGxd0tNxb3T+DVs56Frc6smaI
         V5c70j+2dConAv/6P7sk0oOliSXTwiI4w0E4CoRdPsRRZSnb6WqR/IcxjSRYNP8++FTp
         AV/widryD9c2A4g8hvzJQi8fQAcaMBeKCkxoiIvSw4X+yjOLVBZEqiLfBNGgLb6k88Q1
         6AI7GT5Xxv1ilexWzv+7IlfaYJOjHC72lhrpmVQtThdN0oqk9RMU2+OSr8B/QeiWjjFx
         9DT8ThB2weH0OeOSoyEwp1T+ki+9qs5lpPO/01odkEBoUiUc/Tioj3QWegP0JSBVr+dK
         cbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859630; x=1728464430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFYM8qk7RMOhwLcJ3G76fKAhgJmVj5Stu3SvCZ6kpWA=;
        b=lCI7+0yeXeLTEv7zIOPsibdRMm1PTVPxMvu1jyuYlTL5aWgfp1+n0AX10JAeBz49lt
         JIkaJfJ6EefTgdy+ZFgfORDG0bjMtqqG7at0KYVXfY0znbltVn/Par61CY9txcDahj48
         B8hhIfysmesaVr0joPN426sbJJsFV8OL2yVuNSySDeWx7DCjq3sMPZIYpHp3HpDRUwTx
         HKLJ48YUc5r1SJTIaKo+FyOYfdGjwJejS0/J5fnvNqCn6TQ7JyCe9po78fRwUn0aqRfs
         PDt+4Youd3v8ga7aogSiqrPEhnjXtl3UgvQ+w0ewDo03pWyG2xqabwh6dHrO2RzsNCoa
         a+/A==
X-Forwarded-Encrypted: i=1; AJvYcCXP2XEcoQ8KTUjfveaYAD2/4En8xrCxL4iBKvbC01g3Hic+l93rQHh+6FHeBZLV5aQD+ZBDQd1aRlnTfIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx92bdYJ7X2Y8DfzYggkZOoS+bm4pHyfVTRZGFegrQ4XwzRevin
	vcR5gQFGFuG85kX2g7gz5qaN/aVDW5U2iyIo0Ub2fqadPIYZsk2Q263fu84V
X-Google-Smtp-Source: AGHT+IFAyEWHjBxR2nUQysQFgRdfwmGryVC+p6JhqCTR4cwPGpWh409Ktr2NRX/uesAt0IjBAa3xrw==
X-Received: by 2002:a05:6402:26d5:b0:5c3:cc7d:c29d with SMTP id 4fb4d7f45d1cf-5c8b18ad256mr1631853a12.6.1727859629495;
        Wed, 02 Oct 2024 02:00:29 -0700 (PDT)
Received: from localhost ([37.161.243.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88240a934sm7587745a12.38.2024.10.02.02.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:00:28 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:00:26 +0200
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org, gregkh@linuxfoundation.org, nfraprado@collabora.com, 
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kselftest/devices/probe: Fix SyntaxWarning in regex
 strings for Python3
Message-ID: <6tlfxlgukpftlfh7z4mwbklcjl74rxixo7xjauyf5dstyhwav2@wvkwd3df5am6>
References: <20240806121500.51337-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806121500.51337-1-alessandro.zanni87@gmail.com>

Hello,

this email is just a friendly reminder to know if the present patch is going to be applied or not.

Thank you.
Best Regards,
Alessandro Zanni

On 24/08/06 02:14, Alessandro Zanni wrote:
> Insert raw strings to prevent Python3 from interpreting string literals
> as Unicode strings and "\d" as invalid escaped sequence.
> 
> Fix the warnings:
> 
> tools/testing/selftests/devices/probe/test_discoverable_devices.py:48:
> SyntaxWarning: invalid escape sequence '\d' usb_controller_sysfs_dir =
> "usb[\d]+"
> 
> tools/testing/selftests/devices/probe/test_discoverable_devices.py: 94:
> SyntaxWarning: invalid escape sequence '\d' re_usb_version =
> re.compile("PRODUCT=.*/(\d)/.*")
> 
> Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from
> discoverable buses")
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
> 
> Notes:
>     v3: Reduce changelog lines lengthy, add warning messages
>     v2: Imperative mode description, add previous commit tag fix
> 
>  .../selftests/devices/probe/test_discoverable_devices.py      | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/devices/probe/test_discoverable_devices.py b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
> index d94a74b8a054..d7a2bb91c807 100755
> --- a/tools/testing/selftests/devices/probe/test_discoverable_devices.py
> +++ b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
> @@ -45,7 +45,7 @@ def find_pci_controller_dirs():
>  
>  
>  def find_usb_controller_dirs():
> -    usb_controller_sysfs_dir = "usb[\d]+"
> +    usb_controller_sysfs_dir = r"usb[\d]+"
>  
>      dir_regex = re.compile(usb_controller_sysfs_dir)
>      for d in os.scandir(sysfs_usb_devices):
> @@ -91,7 +91,7 @@ def get_acpi_uid(sysfs_dev_dir):
>  
>  
>  def get_usb_version(sysfs_dev_dir):
> -    re_usb_version = re.compile("PRODUCT=.*/(\d)/.*")
> +    re_usb_version = re.compile(r"PRODUCT=.*/(\d)/.*")
>      with open(os.path.join(sysfs_dev_dir, "uevent")) as f:
>          return int(re_usb_version.search(f.read()).group(1))
>  
> -- 
> 2.43.0
> 

