Return-Path: <linux-kselftest+bounces-11921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C265190875D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 11:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD69A1C2316B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9709E1922F6;
	Fri, 14 Jun 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfraxG/q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D813CF9E;
	Fri, 14 Jun 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357176; cv=none; b=I+Wv40XxKnrP8bNS+HXs5WEhwIwEIm86ETVv7SyckQC9hvm9lVh6SQCLe7gkKb08kyCcmQLJn0QKm4nMXcidcOmxLeCaQuKw9J7zGU8yE5qvQ/C0+XUxfg/zYdzjJCL/0V/HJ5iYE27Hl0SOKLs8nH57KHGPURZbF4Tgq/MwqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357176; c=relaxed/simple;
	bh=RjYVsVZeskO22hC0XBoe6PRuahJdiNbuYlh8UW4q9Ec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T3zZwS0t/jo/w4uv2W2dtEaDpwuQEWGqEkJJocGXpogLMACkqYGHaZwm6ciegGHteCtQizm/75e0VPkLf3MqUeTT8Np+iGdvNozXdjmz0zbO7AW32eg80CpuQOHVhKqKqJPMoUe85cS8xn+fo8FD4ehmcvuq2oSqmIl5jSI5zWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfraxG/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6FFC2BD10;
	Fri, 14 Jun 2024 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718357175;
	bh=RjYVsVZeskO22hC0XBoe6PRuahJdiNbuYlh8UW4q9Ec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GfraxG/qnai6WqVA80nwF7muZOesCiDzZ+eUnImSYE5OGqTAUyilOspk8wO/qTtnL
	 xX2pdKAOy1LTLgnMMuOclxWhZZGgYZGmmWokMWZ72uDXAKnLJQ7lHQmZzx0vdTK8yo
	 xMn1i8Ks4VfHCal5SZ6mH+S/UGCIpPxFGP9P2uhlKO2TQIYQc/dI0Z8dKo4fJaavvB
	 NLmDGEDPPuXbSQ8lFbFT92yqiQBU0yGiVpTsDpcp1FUbR+rnM1Sad96/P0kLbRsLIH
	 t+bBTlPtqWMrkzcxzS/WLyAF48b//KdIBxFiYaFravb5cWH83jNbJT2vWClqtWdssC
	 c6ne2G/9BLbsg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Peter Hutterer <peter.hutterer@who-t.net>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
Subject: Re: [PATCH HID v3 00/16] HID: convert HID-BPF into using
 bpf_struct_ops
Message-Id: <171835717356.456783.6239687806060827051.b4-ty@kernel.org>
Date: Fri, 14 Jun 2024 11:26:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

On Sat, 08 Jun 2024 11:01:12 +0200, Benjamin Tissoires wrote:
> The purpose of this series is to rethink how HID-BPF is invoked.
> Currently it implies a jmp table, a prog fd bpf_map, a preloaded tracing
> bpf program and a lot of manual work for handling the bpf program
> lifetime and addition/removal.
> 
> OTOH, bpf_struct_ops take care of most of the bpf handling leaving us
> with a simple list of ops pointers, and we can directly call the
> struct_ops program from the kernel as a regular function.
> 
> [...]

Applied to hid/hid.git (for-6.11/bpf), thanks!

[01/16] HID: rename struct hid_bpf_ops into hid_ops
        https://git.kernel.org/hid/hid/c/146a06a0d225
[02/16] HID: bpf: add hid_get/put_device() helpers
        https://git.kernel.org/hid/hid/c/99b40bf8053f
[03/16] HID: bpf: implement HID-BPF through bpf_struct_ops
        https://git.kernel.org/hid/hid/c/ebc0d8093e8c
[04/16] selftests/hid: convert the hid_bpf selftests with struct_ops
        https://git.kernel.org/hid/hid/c/d7696738d66b
[05/16] HID: samples: convert the 2 HID-BPF samples into struct_ops
        https://git.kernel.org/hid/hid/c/e342d6f6f7d8
[06/16] HID: bpf: add defines for HID-BPF SEC in in-tree bpf fixes
        https://git.kernel.org/hid/hid/c/df67602fb8d5
[07/16] HID: bpf: convert in-tree fixes into struct_ops
        https://git.kernel.org/hid/hid/c/50fe0fc6e206
[08/16] HID: bpf: remove tracing HID-BPF capability
        https://git.kernel.org/hid/hid/c/4a86220e046d
[09/16] selftests/hid: add subprog call test
        https://git.kernel.org/hid/hid/c/05b3b8f19441
[10/16] Documentation: HID: amend HID-BPF for struct_ops
        https://git.kernel.org/hid/hid/c/c5958697a5fa
[11/16] Documentation: HID: add a small blurb on udev-hid-bpf
        https://git.kernel.org/hid/hid/c/5f42e19de53f
[12/16] HID: bpf: Artist24: remove unused variable
        https://git.kernel.org/hid/hid/c/26ba1e0a982b
[13/16] HID: bpf: error on warnings when compiling bpf objects
        https://git.kernel.org/hid/hid/c/c94ae2189aca
[14/16] bpf: allow bpf helpers to be used into HID-BPF struct_ops
        https://git.kernel.org/hid/hid/c/bd0747543b3d
[15/16] HID: bpf: rework hid_bpf_ops_btf_struct_access
        https://git.kernel.org/hid/hid/c/f1a5fb6c7cf6
[16/16] HID: bpf: make part of struct hid_device writable
        https://git.kernel.org/hid/hid/c/33c0fb85b571

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


