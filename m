Return-Path: <linux-kselftest+bounces-3237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ABD83296F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 13:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDC1284FD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28BA4F1F6;
	Fri, 19 Jan 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtYhRW2i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C613C499;
	Fri, 19 Jan 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667029; cv=none; b=Dv6Bcc5jy1EhwrPknfwoHREwX6bB3p1grOkzrz4JsyDJxL1pTPwv1ReOH6cAP0knR69kukhgDFFaZrFI66J+VNT38AbtGZ74XDhydd3LgJ+vzTA2eDjW0Z+4toZFo32nrxuXzIYAMnhP17jZ1HZGq8klGwm2B013ht9gjzYuCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667029; c=relaxed/simple;
	bh=uBY94QNQ8IlqeoaQVLgckjGtysQqcnaeus3ynVCXJm4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AX9wbrm5cfM3kvnkhqeE9XfrNvkfbuVSAAIuBHEOpTZ7Rkh2wYWN4g8AKwASfEIk1rxXdS9mN2QsgFPDf8L871l39W/0WRoe2Juvqp3hOERtotjjQ6w1Kn6ZU495nJpUbY8UkKJnemi0iTyVEuna3tOM+i95/9kXqtBPS/8MA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtYhRW2i; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337c5eb1bddso595091f8f.3;
        Fri, 19 Jan 2024 04:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705667026; x=1706271826; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v4VkxtsHOdUE4TpdWjEGpimNl0b6w54iAmLNYkEcmy8=;
        b=GtYhRW2i7W0l3qtcMMFDacou2+93D0qPiaYsqhko6cWmVOmCrcLdaZaznZLV05dosH
         h9bE7xGLUU0iyHgNNGypbr4afm0+BCvfiHA9XFITH6WGlLIg/qdfGLYLCCw6pWeNmkI4
         ld0JSk5ezjmLDDlatMC8evbbjCaRgXLhc9p4NLoaRZgWAz0kvld3eHJusVBiqFIuliYo
         Cx7kWlrtKghUV22ufeml1Xcn6ZShBX2RZnvuqC6L85oRx7eFmZe+CjOs6M0QEq4Xc/xi
         1mvCG2AqaEWUk4q6lEauuO86X+cbrjSH6A8Vzdy/DuQRL6umwJxKia7xQNy3BbZ6rPZK
         ovVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705667026; x=1706271826;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4VkxtsHOdUE4TpdWjEGpimNl0b6w54iAmLNYkEcmy8=;
        b=FdnvQtUwcU9/6rFUYlI1v7UlvhopLI0DazdLicPSRJCfaIvefTwvN1Vx0XkTZ80NCU
         B2zFr0D49m8O1RiDBL8JUU1RyiZQSSxBNI3B2FImGJ9ZKbFsM/4tvKTxU85xvZtLOngE
         qU0RnBeqcg5G30PYamya47GYv4CpgW77xn4C5CTc+xWnwFqkpsMWA9uy9eiTuG6pVG09
         N9E5GUsNi+Kf6KnHlQkYIRV51Yd3QuhVMsCIDFRkK9HJPKG9Fbb+s4hgAkK+KtumFWOX
         atc5AA9KJ1lVsDA6XB+iJ/O+ksy5h3TFcOeY6nN6rV6AGAnPHySFu6Pym1xYsGlpQ/38
         bNhQ==
X-Gm-Message-State: AOJu0Yx14VB1iDBdzrCv2dG0Msbb6yn1bnsL/vES2T/rbGm1QFfyP65A
	zCGStgIStp4xG0rKtGUEKEMkhTXDN9OZjaUDlZuaLgh8edFlsA+3
X-Google-Smtp-Source: AGHT+IF1frQZcgXGi0SS6En7PJKEYIiUU61X/yAcKZ+RPbP1csMmSr+TOLndCJVy0+COd95+vgFQGQ==
X-Received: by 2002:a05:600c:470c:b0:40e:62e6:d256 with SMTP id v12-20020a05600c470c00b0040e62e6d256mr1387524wmo.21.1705667026341;
        Fri, 19 Jan 2024 04:23:46 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d610b000000b00336ca349bdesm6370138wrt.47.2024.01.19.04.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 04:23:45 -0800 (PST)
Message-ID: <71ac757d092c6103af7c6d0ebb4634afcaa0969a.camel@gmail.com>
Subject: Re: Re: lsm_cgroup.c selftest fails to compile when CONFIG_PACKET!=y
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, Andrii Nakryiko
	 <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Yonghong Song
	 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Jan 2024 14:23:44 +0200
In-Reply-To: <uf7fpvox2s3ban33ybixlg2buxbh2ys2gl7wjrphuip2qrdsjr@56dp2546tuuu>
References: 
	<f4l6fadtxnvttlb27heyl3r2bxettwwfu5vrazqykrshvrl3vm@ejw2ccatg3wi>
	 <0c0a7705e775b2548f3439600738311830dbe1a9.camel@gmail.com>
	 <uf7fpvox2s3ban33ybixlg2buxbh2ys2gl7wjrphuip2qrdsjr@56dp2546tuuu>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-19 at 16:04 +0800, Shung-Hsi Yu wrote:

[...]

> Final goal would be have BPF selftests compiled and test against our own
> kernel, without having to come up with a specific kernel flavor that is
> used to build and run the selftest. For v5.14 and v5.19-based kernel it
> works: compilation is successful and I was able to run the verifier
> tests. (Did not try running the other tests though)

You mean ./test_verifier binary, right?
A lot of tests had been moved from ./test_verifier to ./test_progs since.

> > As far as I understand, selftests are supposed to be built and run
> > using specific configuration, here is how config for x86 CI is prepared=
:
> >=20
> > ./scripts/kconfig/merge_config.sh \
> >          ./tools/testing/selftests/bpf/config \
> >          ./tools/testing/selftests/bpf/config.vm \
> >          ./tools/testing/selftests/bpf/config.x86_64
> >=20
> > (root is kernel source).
> > I'm not sure if other configurations are supposed to be supported.
>=20
> Would it make sense to have makefile target that builds/runs a smaller
> subset of general, config-agnostic selftests that tests the core feature
> (e.g. verifier + instruction set)?

In ideal world I'd say that ./test_progs should include/exclude tests
conditioned on current configuration, but I don't know how much work
would it be to adapt build system for this.

