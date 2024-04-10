Return-Path: <linux-kselftest+bounces-7575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D392789FCEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 18:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107051C23314
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC16517A934;
	Wed, 10 Apr 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iheQ0+ts"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76411779A9;
	Wed, 10 Apr 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766795; cv=none; b=ad12oPhoDkoweEiyfMFrkMKP2tfIZ6gzlpqLqrnIWAWoVWnI+8wFZMAaCdLixUH5UpbTtJw+EpOpJ/9YGCyCHB3cuhOx7vKRCcXx2UObFqQeBzos15d0SaFarbzDqUd2hvgIY+GaVCzCnrW/xj48bJnYes+kbGjvWqnjOv9RnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766795; c=relaxed/simple;
	bh=zdTTjqN5WOW+ZJIVOucJmi2IMTJ4bUsqkj4XLk6YKwM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fqQFDIUtOkeMQiokNuVbuak+jzk0Fzj6hbf9gSrlpBZnjCgzdZ8mc+3SGg1XgKLeDjqvmBcT1VSTL9n2LEGsu1z1hsoWij1i7ZzbLRzmtHdAtqvUDBmOK0zF6ol4qfazEPnynP2euYsxubXoLuKbJFrSxzwnKS6yAv4xG2AaCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iheQ0+ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6600BC433F1;
	Wed, 10 Apr 2024 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712766795;
	bh=zdTTjqN5WOW+ZJIVOucJmi2IMTJ4bUsqkj4XLk6YKwM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iheQ0+tsS/+/j5Q42qjq17Zxf+AuuDQUSsFT26iJKvJ48IulqrEysb21kIUpm0ruO
	 DznIGY5BTtI+UC0eqoSPCfB6EzHnzLkAK5JjHhZtBgP9CugrwtQqIHYgOo9ForvpSk
	 HLeu3nQCu/pI2fAMJpJ2WrwAlr3OOPNQBpnywduPyBeC94NZI3g9NRb9kPCHOWppfe
	 ZCDGrDUuWcDOA70w58YqoSKqGq2Vb2cpxEuXdBZmfahArE1/WbVgzKMCONUvGFv45L
	 wRh33Wn4rXzNFx7jeExvXXAuH/mBIyDR6Oz41fgDA1b0rMFcBjXNNXUjV66aSHfM6e
	 Z7BCdbJKo7e4Q==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
References: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
Subject: Re: [PATCH v4 0/7] Extend HID-BPF kfuncs (was: allow HID-BPF to do
 device IOs)
Message-Id: <171276679313.377823.15584724900641468692.b4-ty@kernel.org>
Date: Wed, 10 Apr 2024 18:33:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

On Fri, 15 Mar 2024 15:44:37 +0100, Benjamin Tissoires wrote:
> New version of the sleepable bpf_timer code, without BPF changes, as
> they can now go through the HID tree independantly:
> 
> https://lore.kernel.org/all/20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org/
> 
> For reference, the use cases I have in mind:
> 
> [...]

Applied to hid/hid.git (for-6.10/hid-bpf), thanks!

[1/7] HID: bpf/dispatch: regroup kfuncs definitions
      https://git.kernel.org/hid/hid/c/4171954f56fb
[2/7] HID: bpf: export hid_hw_output_report as a BPF kfunc
      https://git.kernel.org/hid/hid/c/5599f8019661
[3/7] selftests/hid: add KASAN to the VM tests
      https://git.kernel.org/hid/hid/c/c8a1495947ff
[4/7] selftests/hid: Add test for hid_bpf_hw_output_report
      https://git.kernel.org/hid/hid/c/db624e82c55f
[5/7] HID: bpf: allow to inject HID event from BPF
      https://git.kernel.org/hid/hid/c/9be50ac30a83
[6/7] selftests/hid: add tests for hid_bpf_input_report
      https://git.kernel.org/hid/hid/c/2c0e8ced7d4b
[7/7] HID: bpf: allow to use bpf_timer_set_sleepable_cb() in tracing callbacks.
      https://git.kernel.org/hid/hid/c/685dadafbde2

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


