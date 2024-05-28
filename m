Return-Path: <linux-kselftest+bounces-10785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBCB8D1C9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BEC1F22071
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BB0172BD9;
	Tue, 28 May 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJCJQAcQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AE3172BD4;
	Tue, 28 May 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902142; cv=none; b=bWAVWJ3y9drUVT/UzIXuvu+R/n4cj1lcfqN1WwuhrbnGg7l/V/Rl8Z7aV1pjRYYu/Hdc+uM1P4GYIZ2tqpWGtBUi3ApEbKZaUoEt8LomphIiODngJCdrPAdMnupl960rY9EaguTGXVhCOqEac5GdSoRrH0y4rIOwkw3cEynEM3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902142; c=relaxed/simple;
	bh=LLJuXzECrzZ19dHpKyqnDZSibpJxTRfPg9I8vzVwFcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AYdbI/Gpa45vrQMNyGMATlK1L/nNNvYTtMYm5JUc3ico6ricTYYzZ6ay/ePc7EJEuROyJcoLZVDhIV5Ud24oJZdlA41cKUynBYVWUXw33Tqk3/5KMTrB6cPGgjS4YXyCk85VzUy6OZjT+8m5sBkRi2G+aFgG1/GL5YxqctVGU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJCJQAcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1753AC32786;
	Tue, 28 May 2024 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902142;
	bh=LLJuXzECrzZ19dHpKyqnDZSibpJxTRfPg9I8vzVwFcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VJCJQAcQBgk6xkDpzbLMmqte9kI2Ctyr2cwKZxsLcBzkKdZNT1fxhYZl1FUgZ952L
	 IRd+mb/60E+MWw8KkvIU7yXgtTmLcB+UGaghXMWmOf49JmIIIfhUwDTbVGJF16DDCo
	 x/5jjoNyiuaUCINAU54qbNRB7sxYA/h60WPLZh+jOcPEgOqXt760Qea64MAbSJfhVk
	 ZrCl41egkFz/tSZ8EddPufzp7Tt6cG+/Ha/8S0uympivDs+bmjHWaTjxmXXxvUHabu
	 HRmplyMCGfQzojoSYlH061xSuhu4QtqbLHYFcGPHkej1c6nqVGuvGqV5S05wkTSt5n
	 SXgornPnFFd9A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 28 May 2024 15:14:49 +0200
Subject: [PATCH HID 11/13] Documentation: HID: add a small blurb on
 udev-hid-bpf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-hid_bpf_struct_ops-v1-11-8c6663df27d8@kernel.org>
References: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
In-Reply-To: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716902113; l=1778;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=LLJuXzECrzZ19dHpKyqnDZSibpJxTRfPg9I8vzVwFcU=;
 b=ellvHsaUddXd2866gyZVKvMLF/FI6KsxQvQH1L7/peDA9c6YBxzrBFBTDUJ/LjVT/pa+t3WoG
 yhiT9pPClYSBUEU3mrQ4MXbMUK55xpp/gkCPLWOWUFBAY8xfpZ2pBBw
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is the current decision we took: we don't provide automatic loading
of HID-BPF by the kernel directly, but rely on an external tool for it.

This tool is currently udev-hid-bpf, so let's make people aware of it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 Documentation/hid/hid-bpf.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
index bb8457bf15dd..7b151a2aef63 100644
--- a/Documentation/hid/hid-bpf.rst
+++ b/Documentation/hid/hid-bpf.rst
@@ -129,6 +129,23 @@ When a BPF program needs to emit input events, it needs to talk with the HID
 protocol, and rely on the HID kernel processing to translate the HID data into
 input events.
 
+In-tree HID-BPF programs and ``udev-hid-bpf``
+=============================================
+
+Official device fixes are shipped in the kernel tree as source in the
+``drivers/hid/bpf/progs`` directory. This allows to add selftests to them in
+``tools/testing/selftests/hid``.
+
+However, the compilation of these objects is not part of a regular kernel compilation
+given that they need an external tool to be loaded. This tool is currently
+`udev-hid-bpf <https://libevdev.pages.freedesktop.org/udev-hid-bpf/index.html>`_.
+
+For convenience, that external repository duplicates the files from here in
+``drivers/hid/bpf/progs`` into its own ``src/bpf/stable`` directory. This allows
+distributions to not have to pull the entire kernel source tree to ship and package
+those HID-BPF fixes. ``udev-hid-bpf`` also has capabilities of handling multiple
+objects files depending on the kernel the user is running.
+
 Available types of programs
 ===========================
 

-- 
2.44.0


