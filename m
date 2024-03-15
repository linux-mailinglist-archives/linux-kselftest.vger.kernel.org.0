Return-Path: <linux-kselftest+bounces-6361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2746F87CF55
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56041F20FDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E5D48CF2;
	Fri, 15 Mar 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5L7FB7Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6046487B5;
	Fri, 15 Mar 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513905; cv=none; b=RaHlV50ODyKx0R3v4hOO9GGCtEJlbvp1Elrpo9Jksn5vJl2p9RNDG63MLD/jbT+WvayRMJT2KJRdGSdFe08Tg2+BvqSSW/8AJNunSOD9KKZSYQ9t/jKOPBEB6lmtLE6/qxmBvWueEfCEd97jWnVM2T4k99iLPnRBSC+vhFIWfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513905; c=relaxed/simple;
	bh=pHSHMrnqR0ZCUlfOmkPFExxeq+HQHfhP88ZBOTpK7+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNqxOdDpu5N5/ynQcyLx5R6YIfi4MFo2WxyVtK4wEvtvtXZA4x/yEKuYt5Ss7CWVclNwm8/iyq3f9193uarRMastLCsb3GLmUJWCw0SshoXeGzaDsgrSyZ0YUtZAn1nN9YSyobvIS5C2l0WPtXtQSrbmlBpONxx80FGheIfX/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5L7FB7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF12C433C7;
	Fri, 15 Mar 2024 14:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513905;
	bh=pHSHMrnqR0ZCUlfOmkPFExxeq+HQHfhP88ZBOTpK7+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k5L7FB7ZPJtTBZL1lfjZb4NkQC98oCeF4hiesYmJWVwHzkLUHvfqxpwCFRRn2kLr7
	 3Sk8riGIe8rYazkDUkbaNk3wjmXBYybetTp0iyIw9JJLxusH2eLYFaz/mgxoMPsB9x
	 1BWcqe83XsD5fzeHuS9DJS6AT/jdyfLPXPCHCzJFylPJudi6QXWDGLIQx/atyOkaZO
	 nknUIiRPIm2cPbsmqTVMaro3/xY32t/CTKgJFeMpjZkN7tdW8vWW3pyP0wHs5ghMmH
	 /NulkRAvne/o8lYJak4oHcXaZHWRVjibwsJkNHxqMV4UiWftOhisHeEUNYT0KJnH/R
	 mw2QeyKmdVDtQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 15 Mar 2024 15:44:44 +0100
Subject: [PATCH v4 7/7] HID: bpf: allow to use bpf_timer_set_sleepable_cb()
 in tracing callbacks.
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-hid-bpf-new-funcs-v4-7-079c282469d3@kernel.org>
References: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
In-Reply-To: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710513885; l=1287;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=pHSHMrnqR0ZCUlfOmkPFExxeq+HQHfhP88ZBOTpK7+U=;
 b=neXHs6HmauwDcYyxZkB2zyEGDGkjjsb/jB2ZqXOyT2E7aR7xhzlaptJaXq5rkpXzM0p9yQoUE
 2jmWyF+kMQFBp22CSeJfCS4DRsYQJC8xJunXMCcIiD+QUwgS+VGwPxv
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Export the sleepable kfuncs we have on HID-BPF in tracing bpf programs,
but with the condition of being used in a sleepable context.
This allows to use the bpf_timer when used in a sleepable context
through bpf_timer_set_sleepable_cb() and initiate work from a device event.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v4

no changes in v3

new in v2
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index e1a650f4a626..e27c2ffb4f60 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -544,6 +544,11 @@ __bpf_kfunc_end_defs();
  */
 BTF_KFUNCS_START(hid_bpf_kfunc_ids)
 BTF_ID_FLAGS(func, hid_bpf_get_data, KF_RET_NULL)
+BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
 BTF_KFUNCS_END(hid_bpf_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {

-- 
2.44.0


