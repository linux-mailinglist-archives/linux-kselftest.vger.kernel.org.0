Return-Path: <linux-kselftest+bounces-13005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB49F91DF8D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 14:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D9AB22C3F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95515A84A;
	Mon,  1 Jul 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGNrnIkP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530CD15A845;
	Mon,  1 Jul 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837612; cv=none; b=fYsm8H4Rd2wCfZi4bbipp8oDC9Z2U0dSg8hFFWhvNgIGn3BC+eSUI+fdp20psQZwxUrxtruZbj9B9rJHhoy9jF01MHpS7GWW860+Oeni9h406ryUPpBk6XTgyxAqiMpnzhUqtbQTim4+pOzLxAPgjV/l72mS9zB1xjRqr9N4xdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837612; c=relaxed/simple;
	bh=dsmN/zf/YtgP2EykpUG92Zxz2PvaV7++5taqu/0esKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hPIGoWW9ls4fvi8cYF9dQsXSmLUyKp8cxIXYA5EgVUjeoivuZqfAszgKVNWYdXRE9+gio96MC4O0eTDz2BbwlF1QjwTPF5skV4Pe4CuqzBjW2FLPKwgtIZqvijEWioer8iqDyMhc2KzyeW3IK+SCp0p0ZXIGX0g1NN+TvFAq3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGNrnIkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBC8C4AF0F;
	Mon,  1 Jul 2024 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719837611;
	bh=dsmN/zf/YtgP2EykpUG92Zxz2PvaV7++5taqu/0esKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dGNrnIkPj+/IK8wTGxsaidn1XFnNmcMSzDgZBXA7c7gkgiO1TyyeHNsyCEOSs8+zW
	 kTgASKZMsxKV+94gNNv3yDDEC3i3d4RJlP+Ce2DSf1v70vlFYJtQpWETJsEikVGI6S
	 cGtJsSU8tH9OnxDBDmbuqbvu6d/5SXI7+wVfQsVNQm1LxaJJcQf7ihDGmr/dmIBkZt
	 SY2qBhKt0qVIQ1K4sDAQWZduVWu7lzAZ8VCFV3mzy5nclDImP0wEtxg4mH9wziDeiK
	 b09VqO7fYiSOI7jrnLwvv4cbzVboUw5WYdYXuYMG+Uj63D321a4o+WWnHDWvNtZCDq
	 nvZnseSmaw86g==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 01 Jul 2024 14:39:51 +0200
Subject: [PATCH v2 3/4] HID: bpf: doc fixes for hid_hw_request() hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-fix-cki-v2-3-20564e2e1393@kernel.org>
References: <20240701-fix-cki-v2-0-20564e2e1393@kernel.org>
In-Reply-To: <20240701-fix-cki-v2-0-20564e2e1393@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719837604; l=2053;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=dsmN/zf/YtgP2EykpUG92Zxz2PvaV7++5taqu/0esKk=;
 b=0mGPyuS8+OZXWy1HD+cL3nkge80bCLhcWj+DlxBoX7NNSyFmpOqCiwbMBNFYs2WwZraTNQaAa
 WrAxPZH3Z3FCseMbIFcCqOJeFRdO72g6UbI1bQ5E7HO9EveogRQMLQX
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We had the following errors while doing make htmldocs:
Documentation/hid/hid-bpf:185: include/linux/hid_bpf.h:144:
	ERROR: Unexpected indentation.
Documentation/hid/hid-bpf:185: include/linux/hid_bpf.h:145:
	WARNING: Block quote ends without a blank line;
	unexpected unindent.
Documentation/hid/hid-bpf:185: include/linux/hid_bpf.h:147:
	ERROR: Unexpected indentation.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 8bd0488b5ea5 ("HID: bpf: add HID-BPF hooks for hid_hw_raw_requests")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 include/linux/hid_bpf.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 3f6584014311..c30c31b79419 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -139,12 +139,15 @@ struct hid_bpf_ops {
 	 *
 	 * ``ctx``: The HID-BPF context as &struct hid_bpf_ctx
 	 * ``reportnum``: the report number, as in hid_hw_raw_request()
+	 *
 	 * ``rtype``: the report type (``HID_INPUT_REPORT``, ``HID_FEATURE_REPORT``,
-	 *            ``HID_OUTPUT_REPORT``)
+	 * ``HID_OUTPUT_REPORT``)
+	 *
 	 * ``reqtype``: the request
+	 *
 	 * ``source``: a u64 referring to a uniq but identifiable source. If %0, the
-	 *             kernel itself emitted that call. For hidraw, ``source`` is set
-	 *             to the associated ``struct file *``.
+	 * kernel itself emitted that call. For hidraw, ``source`` is set
+	 * to the associated ``struct file *``.
 	 *
 	 * Return: %0 to keep processing the request by hid-core; any other value
 	 * stops hid-core from processing that event. A positive value should be
@@ -153,7 +156,7 @@ struct hid_bpf_ops {
 	 */
 	int (*hid_hw_request)(struct hid_bpf_ctx *ctx, unsigned char reportnum,
 			       enum hid_report_type rtype, enum hid_class_request reqtype,
-			       __u64 source);
+			       u64 source);
 
 	/**
 	 * @hid_hw_output_report: called whenever a hid_hw_output_report() call is emitted

-- 
2.44.0


