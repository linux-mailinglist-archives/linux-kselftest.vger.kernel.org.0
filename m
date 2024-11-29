Return-Path: <linux-kselftest+bounces-22622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2439DE881
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 15:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57EE2813F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF12C18C;
	Fri, 29 Nov 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAmUp7JU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91956446;
	Fri, 29 Nov 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890467; cv=none; b=ow2dyqC0FMs6Uu5gK/ArcKVEWWisfac/eBxiQqB2LRuNC9uAkhOojWVwCamIiFdb2yyVp/D28IBtRrbr9fTLJmr07MFbW85d2eNceAoaG5FkfjDPBGBmIT4i/r8khtpRj4uONt3FLFe5fSpaa2o0h5Df9UX7IF4DjGVdYnF9vh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890467; c=relaxed/simple;
	bh=+vgPJHybP12C8neovOe11buOLbgLCn81+/KHl0rFaXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IDJtOXRYkqeSKASenbbxui4GZc3FoUzoW0DLilynvUSZwUyjDglb+AtM8MV8UH4NwYzxsAYLft7JUbx8db9TWMSsW0Mc+OSccM56gizsjTwybvzLruxtsOOuD3jlLjVrt7T89FN/ceHZYiGk2BHoG1m7/d4aHttgKXSV8AomYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAmUp7JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF830C4CED9;
	Fri, 29 Nov 2024 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732890467;
	bh=+vgPJHybP12C8neovOe11buOLbgLCn81+/KHl0rFaXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uAmUp7JU3Wi6DpNkeFilNifVBjYqQTtbHadzNwmxp63oKbDV9oCI1LMMlwo2K5X0G
	 RLQvIatVVK8GiVl6tSqMOmNHf9JmWXwgW13tHDEWKtDUFKEtLsXPhH62OjdtiCREP1
	 Ei6I9EQyMsTxWI9FnnV84RzXtshrA8CI4Yhj845V4x0lWLYfxxZW6PziuuTNirf9sZ
	 /Zbt+aIR7LhtJnC11Fg6WO/GnrzbbsV+pHBWNEiGfY+T3ZHPhpr3anFEwf/DNXst4O
	 9R5IAxT3QFnAXafTA5iPgViV5SDSA4KAITpIxTDDPKdUNlVFbsJOcknrnvPre3uGdn
	 fEe1MHZxq9/XA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20241128-fix-new-bpftool-v1-1-c9abdf94a719@kernel.org>
References: <20241128-fix-new-bpftool-v1-1-c9abdf94a719@kernel.org>
Subject: Re: [PATCH HID] selftests/hid: fix kfunc inclusions with newer
 bpftool
Message-Id: <173289046549.2537695.13447881314458341345.b4-ty@kernel.org>
Date: Fri, 29 Nov 2024 15:27:45 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Thu, 28 Nov 2024 14:27:16 +0100, Benjamin Tissoires wrote:
> bpftool now embeds the kfuncs definitions directly in the generated
> vmlinux.h
> 
> This is great, but because the selftests dir might be compiled with
> HID_BPF disabled, we have no guarantees to be able to compile the
> sources with the generated kfuncs.
> 
> [...]

Applied to hid/hid.git (for-6.13/upstream-fixes), thanks!

[1/1] selftests/hid: fix kfunc inclusions with newer bpftool
      https://git.kernel.org/hid/hid/c/8d355b56f295

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


