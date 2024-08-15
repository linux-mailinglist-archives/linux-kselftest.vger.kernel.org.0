Return-Path: <linux-kselftest+bounces-15417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314DB953769
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 17:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB9B282F47
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631751ABEC4;
	Thu, 15 Aug 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObQkE2vw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03E19DF92;
	Thu, 15 Aug 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736241; cv=none; b=K6Yz0yItqhWL2tFl2/5rLJ9QWOBa/9k3DT16zlwcrygaQvhe0DC8Y9gN+8C/LkylzHnT+7QIU/BGfjrwujjo+9vtn0UA7NrwVGxZVz5lEUbUtDQy2eAIesppvvU3OasguW4OSL3XS4/3UIje2jZSeSdgWWbfzUVFtzgLa5HQ+Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736241; c=relaxed/simple;
	bh=l0HOjb5v7Td6b7+4wjyPWOza7JPXStwNXiC9vrsrtXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oOD23L9bfyqOGkCzDgPj95N5Y6FYOf5ZeVcLMuvdlpqRP8qeM6Zfyj27o2Q0ttWwFFCm5x0ZZWhufvocqOqqBAbRbb20DU4VULSAoHAZ9zavzaj0QEF1Y6qJkFnZeWteTX01oNOQW3z0c26YloAApxjphTY1jlIxhNLao6eF9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObQkE2vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A22C32786;
	Thu, 15 Aug 2024 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723736239;
	bh=l0HOjb5v7Td6b7+4wjyPWOza7JPXStwNXiC9vrsrtXw=;
	h=From:Date:Subject:To:Cc:From;
	b=ObQkE2vwR7Xy8BPJb9RtXIvKjISUxYIsCF9f3z9NId4DpxIhFLcgZFky8srnHKbQ+
	 GIAiU/bWKeG+tqdjJ0ULMvndN8czTr6gkv+2y+TYMaeQABVTowfc30IGsj2cfKH8jg
	 F5+X5Q1Muq/lE69meP7+tLnQu8pk4tmCflmg6pZcu4UUJhNYpuMm+Xt7eTdGQGm3rb
	 +e2Qeoabzu+HHBwyCW+jYlNpOJTWZq3I/xN36LmUnSAwhVU4nGZeLI9xrhOdZwb9xt
	 wlfJ5XU5D4y5e1Y+NyAM/5TRpeJnOV4fahrM2sxmpiz2TpdHkV1PoNSJcEETHONKHk
	 tcM9K/Rh1L6XA==
From: Simon Horman <horms@kernel.org>
Date: Thu, 15 Aug 2024 16:37:13 +0100
Subject: [PATCH net] tc-testing: don't access non-existent variable on
 exception
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-tdc-test-ordinal-v1-1-0255c122a427@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKggvmYC/x3MTQqAIBBA4avIrBuwwejnKtHCcqqB0FCJILp70
 vJbvPdA4iicYFAPRL4kSfAFdaVg2a3fGMUVA2ky2pDG7BbMnDKG6MTbA83cm75tOmqpgZKdkVe
 5/+UInjNM7/sBKZCUtmcAAAA=
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 Shuah Khan <shuah@kernel.org>, Lucas Bates <lucasb@mojatatu.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.0

Since commit 255c1c7279ab ("tc-testing: Allow test cases to be skipped")
the variable test_ordinal doesn't exist in call_pre_case().
So it should not be accessed when an exception occurs.

This resolves the following splat:

  ...
  During handling of the above exception, another exception occurred:

  Traceback (most recent call last):
    File ".../tdc.py", line 1028, in <module>
      main()
    File ".../tdc.py", line 1022, in main
      set_operation_mode(pm, parser, args, remaining)
    File ".../tdc.py", line 966, in set_operation_mode
      catresults = test_runner_serial(pm, args, alltests)
    File ".../tdc.py", line 642, in test_runner_serial
      (index, tsr) = test_runner(pm, args, alltests)
    File ".../tdc.py", line 536, in test_runner
      res = run_one_test(pm, args, index, tidx)
    File ".../tdc.py", line 419, in run_one_test
      pm.call_pre_case(tidx)
    File ".../tdc.py", line 146, in call_pre_case
      print('test_ordinal is {}'.format(test_ordinal))
  NameError: name 'test_ordinal' is not defined

Fixes: 255c1c7279ab ("tc-testing: Allow test cases to be skipped")
Signed-off-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/tc-testing/tdc.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index ee349187636f..4f255cec0c22 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -143,7 +143,6 @@ class PluginMgr:
             except Exception as ee:
                 print('exception {} in call to pre_case for {} plugin'.
                       format(ee, pgn_inst.__class__))
-                print('test_ordinal is {}'.format(test_ordinal))
                 print('testid is {}'.format(caseinfo['id']))
                 raise
 


