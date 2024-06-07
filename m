Return-Path: <linux-kselftest+bounces-11403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F390090F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2ADE1C22899
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49CA19DF68;
	Fri,  7 Jun 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAw7Y4Ck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CEA19D079;
	Fri,  7 Jun 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774138; cv=none; b=G4G+8gEUvkNsHiAvAp+ZSj+y+VAZVQXQSjIRGFSpJRSpBmzBX0LPx+60leAfxUcMEfxHylm+e1TOUSyU54xcesViKML3kugEDHhUJd7f1Di/X+0kDkqBkJWZaO3f4miDrt1mnn+zIyA6kx2CCQEw1IXFybXnav0ZpQCSVB45Kaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774138; c=relaxed/simple;
	bh=Ub7Vy/8HNvQPS41Xo0JZpRJdUsumnTmCiiNeoQ5mm4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HiIxAzufZNXD0MNyEDphxRVhv9ZlPM+p+HUoIY+SfavmTa7AdeNHdz9Wg5gU+s1aoL8gZqDfUku6y65fYqWKSHtb3Ah4fujE4q6uM5nwgwlxyOEvjjqUhlRHTs7vXGN28WKNsDo8U5ZJEuabQe48I+dEuU1Jzdp8WvgOlOQPpZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAw7Y4Ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43373C4AF08;
	Fri,  7 Jun 2024 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774138;
	bh=Ub7Vy/8HNvQPS41Xo0JZpRJdUsumnTmCiiNeoQ5mm4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UAw7Y4CkQzrR7JkwqjpIGuL2GLK33RFwaG6RmSWO1BVV2vlvFEXaqvpeNX66StPMi
	 bBYq3Kv6GoByvDP38k9VhjSzuTBcaCqPLBJgtXKV+rzfI9Lb21yLuiYqfpBkftCyeu
	 yWKYaDsAqXxXoNXVeG6jAoJQj1ZN1pVpQQ97fCJMwUccjrxALD2mQZZcOwIIufE/sj
	 1TlnCirKYyQWvbMoLiNDG8qqh+C0hKlFUmQv2AVD706ip1wg9KRgviW4f67kj4pnJ8
	 UcnQIlmXqdRBjEY3NoXA4fu/14TTVjY/GmwLz3imwlGGzTHjoCNIo9OnPKRTltlCpy
	 K7NbN2HP98HCQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:31 +0200
Subject: [PATCH HID v2 11/16] Documentation: HID: add a small blurb on
 udev-hid-bpf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-11-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=1805;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Ub7Vy/8HNvQPS41Xo0JZpRJdUsumnTmCiiNeoQ5mm4w=;
 b=tLjgFaE9QvQSzzvBBHEXCurid0JKHqKzRRDQuInJwpTJmhuRIPqoIR2ASYkWWJTyU/Nlz7Q0Z
 ZtehkP30kYZDUMvIohxdZxhSQNFMFQju66E+elnLey/+UIhzaOFFb8R
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is the current decision we took: we don't provide automatic loading
of HID-BPF by the kernel directly, but rely on an external tool for it.

This tool is currently udev-hid-bpf, so let's make people aware of it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 Documentation/hid/hid-bpf.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
index 456e15097d87..8ae8f49801cb 100644
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


