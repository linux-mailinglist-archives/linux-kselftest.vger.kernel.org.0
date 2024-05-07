Return-Path: <linux-kselftest+bounces-9576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E94058BDABB
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 07:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2134B1C21CA5
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 05:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60AF6BB5E;
	Tue,  7 May 2024 05:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="QeQkweQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADWUYd67"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062E6BB20;
	Tue,  7 May 2024 05:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715060652; cv=none; b=fWC3WYOFmLU1L5STQ6H5CwQGlzxhT0j7byhSOxrEuCQdJT3wqDmIKPOwsqwb3RtfBOxQRuR73nLvwDc6NE3mbw05kZtFXVK6MwZs0uVrhXgF696QghqkYgzIh8ms/pHJkhuVpP5A2EUmQx/Oy2RNLX51XmoASsaCnglvxWp55Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715060652; c=relaxed/simple;
	bh=xUUikjw73Z2SWVDsnoMEjL6NWbOu9X7Pm9owE8s4BBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIbiZ3EZo9N7gMLrkT9aaCsIhNDiXxTaqTxjrfQymNhxPN8pxksqwD7lwy+uHbIYTDLyGbM5Tz5KagcI6scZBDGcPuIcB8dgssuh1wqMdwDji9AnddBlatDuspAenFjzOgDjQ1QVOeKy0ZE/Wi6Fh3zzPrYhFCgUye/tL1i/c8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=QeQkweQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADWUYd67; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CA3DA114010D;
	Tue,  7 May 2024 01:44:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 07 May 2024 01:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715060648; x=1715147048; bh=lkeboXyBVp
	NmNRvKnjyj6x8sgel+2B8ncRxdOm+B4m4=; b=QeQkweQ1+bCG+NzV9FSr3Vpu4c
	FR4kr6FpUMW/7D+ATsXbatQPO4TUNVgzI5xIsKhqsthkMm3PEyKqeuFj5QnVj7G2
	YaCx7u00n3QYC9yZvbUrbGz8TQMw4VL96FI3LbAcQ9VGaLqddnlB9tIWgO1zJZfP
	YJ3Xy1iAoLApjkDcBnBGSNr62XV8Cf5AUIbb74D8WjbDFlPavSyCqDv0TEFNfb2i
	dmC/69b3+mvA8OLULvQCGBg1ycREVLf18qnD6sVq+iVYgyPPe6Y3qWZOO4M5Yop0
	xDWRylj+tE8TPn72m+ACjbVm7VQW6eAjzye0st8Rd/dxm7Nz+uBXwJLxdtqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715060648; x=1715147048; bh=lkeboXyBVpNmNRvKnjyj6x8sgel+
	2B8ncRxdOm+B4m4=; b=ADWUYd67gU3t6wO84l5Ys2TG+vpv4c8/rxVA9/MiHsnO
	yGtp70MFyvgpofeyz3UTGPyGP+fPOLLUq4jav5ck951pVKmUDn2R1pmXhoiUySoT
	4ncAFm7yQwB8kJz8AGyZLd8E9sCX9VF61BvZNB2JpbfClwlz+i/UX+rD+hCgomCQ
	2FXfObMv+NqtGjH3ZR9AqamjC1pQDhK5xRzPaRe7IwMVcJtuser+1qAvuQT0NvGZ
	3f7eLmKjwzzdRTOJL7aEOnHgOcdYSTonvdj5XPscDwlOu588sKDqzeG4YKV+gRj5
	z8Nk5R3QQbTOP2Au+jiaPv8qhlpkoqfZsVdz+h0LLQ==
X-ME-Sender: <xms:qL85Zv5bpem87foY8yva3ZgY8BqwUbmp2beoqHOQkps6ny9if3FOgw>
    <xme:qL85Zk57LGYs2HWA1h9x20PXqAJndsUbLChHcaqw7rK_1CNPefxDI2RN9IVoF1dbQ
    vdlNbIARysCmXV9PyM>
X-ME-Received: <xmr:qL85ZmfsAL_w_R1iWvzhNSGuVLfKiH7cuzTXo02qM0GGRu8sVifKr0B44FPINevuvkd9yzhvTZfXrHr9zS91FdgfopNixhamo0xp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeekvdekgeehfeejgfdvudffhfevheejffevgfeigfek
    hfduieefudfgtedugfetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:qL85ZgKeoK0iG_pOUEJyngrRgD-qZQr_WVRyoGXxUmIebKdrh8Eqbw>
    <xmx:qL85ZjLXdN2iGRSViUXKL1eHi372Qb2fMHNxOB3MDI3bKuTAT3YKjA>
    <xmx:qL85ZpwoFYPnJ-VWosex2jtajpeCUaX8e4LZyj5jSygbS7JOvbtIIA>
    <xmx:qL85ZvID7Py1eI5HiL8LHJKKqBawU-stWBtoQR8C2DUWfXGk03iyDA>
    <xmx:qL85Zlya9pfG5BcaMtzX7R0zMqPC7mOPmDqMu59T_SNoal34jwQB_OmQ>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 01:44:04 -0400 (EDT)
Date: Tue, 7 May 2024 15:43:58 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: bentiss@kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-input@vger.kernel.org, Martin Sivak <mars@montik.net>,
	Ping Cheng <pinglinux@gmail.com>,
	Jason Gerecke <killertofu@gmail.com>,
	Aaron Armstrong Skomra <skomra@gmail.com>,
	Joshua Dickens <Joshua@joshua-dickens.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 19/18] selftests/hid: skip tests with HID-BPF if
 udev-hid-bpf is not installed
Message-ID: <20240507054358.GA696790@quokka>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
 <20240506143612.148031-1-bentiss@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506143612.148031-1-bentiss@kernel.org>

On Mon, May 06, 2024 at 04:36:12PM +0200, bentiss@kernel.org wrote:
> From: Benjamin Tissoires <bentiss@kernel.org>
> 
> udev-hid-bpf is still not installed everywhere, and we should probably
> not assume it is installed automatically.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> 
> I wanted to apply this series given that it wasn't reviewed in a month,

apologies. Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

(I have a few improvement suggestions for the hidtools code but it's
better to do those there and then sync back).

Cheers,
  Peter

> but I thought that maybe I should not enforce ude-hid-bpf to be
> installed everywhere.
> 
> I'll probably push this series tomorrow so it makes the 6.10 cut.
> 
> Cheers,
> Benjamin
> 
>  tools/testing/selftests/hid/tests/base.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/hid/tests/base.py b/tools/testing/selftests/hid/tests/base.py
> index 2d006c0f5fcd..3a465768e507 100644
> --- a/tools/testing/selftests/hid/tests/base.py
> +++ b/tools/testing/selftests/hid/tests/base.py
> @@ -8,6 +8,7 @@
>  import libevdev
>  import os
>  import pytest
> +import shutil
>  import subprocess
>  import time
>  
> @@ -240,6 +241,10 @@ class BaseTestCase:
>              root_dir = (script_dir / "../../../../..").resolve()
>              bpf_dir = root_dir / "drivers/hid/bpf/progs"
>  
> +            udev_hid_bpf = shutil.which("udev-hid-bpf")
> +            if not udev_hid_bpf:
> +                pytest.skip("udev-hid-bpf not found in $PATH, skipping")
> +
>              wait = False
>              for _, rdesc_fixup in self.hid_bpfs:
>                  if rdesc_fixup:
> -- 
> 2.44.0
> 

