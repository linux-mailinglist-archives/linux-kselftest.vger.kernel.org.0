Return-Path: <linux-kselftest+bounces-26480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EC6A32DC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 18:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3973F3A1587
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 17:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22683213236;
	Wed, 12 Feb 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igqy8sHc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CE271837;
	Wed, 12 Feb 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382348; cv=none; b=QFy/Sp+h3sn3c7ixTmVv6j0N53h5cb93gz+aG6Ym9LYv98Upld94hdh1EbK4xgn8Rgd0Fg5pBZgEen9MN/iZIZ3TcxGO0uNc15ggtmkBRPGJQ2Fxe/jJybxOX1u6R1fciNr+owoRRzWZdFLWeZ1TWK4uD6sigkRERH2BBVjAWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382348; c=relaxed/simple;
	bh=evN8cM6Q1oIqWCcOtZLAvt/cgxYzIaia5q6Sy4GrOjY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PxeVaT/MdSRcwU0avchJa8SMsoy5Aldx9tDjAcroixPbQCCbcdmdJ5Nhhur3omUBU3tpXHBEMC6ifBYOirWZdV5FvjDikrJZaftxBUSRGMstBtj29pBXhMXanaeI+DxPzkCueB93RQbHx7dtws6/PhQPAzked9PJ8vGEG/poZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igqy8sHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E196EC4CEDF;
	Wed, 12 Feb 2025 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739382347;
	bh=evN8cM6Q1oIqWCcOtZLAvt/cgxYzIaia5q6Sy4GrOjY=;
	h=From:Subject:Date:To:Cc:From;
	b=igqy8sHc00n/VrUZ9n5v84Vzgh655W8Q4dc21nECDQH5kYlEaNLuu1MxPqG/BI0ow
	 pHhZkyf84m6shuA44l8Y2SVerw2V1tUj/rEugVFGHekThpFa7H+XVTDgbSdoWj6t/O
	 5ji//yfkx5RfSbUHK7Gjp8Q58XzkyYsdvee3T5a6+3d967y/9rqmfR6HNIeJ8pgdec
	 0ufBPq/pPIQXtJuEsMvz18JWlQqXT2oRH04BhwT1bq3j9WkTxlNAgSNjMB4RH9xfa4
	 2de4ZFebUb6zfE6PdjIx9k4H2eIylN1akxnfYfvhcY5NX/gNCX3DoypOzhbPWEMQZC
	 Q+ajPJNTrB9LA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] selftests/mm: Allow execution on systems without huge
 pages
Date: Wed, 12 Feb 2025 17:44:24 +0000
Message-Id: <20250212-kselftest-mm-no-hugepages-v1-0-44702f538522@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjdrGcC/x3MQQqDMBBG4avIrB3IBETaq5Quov7GoTVKRkUQ7
 97Q5bd47yJDVhg9q4syDjVdUoHUFfVTSBGsQzF55xvnRfhj+I4bbON55rTwtEesIcIYaB7SBmk
 dOir9mjHq+X+/3vf9A5y+GjxrAAAA
X-Change-ID: 20250211-kselftest-mm-no-hugepages-ee5917a170eb
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=broonie@kernel.org;
 h=from:subject:message-id; bh=evN8cM6Q1oIqWCcOtZLAvt/cgxYzIaia5q6Sy4GrOjY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrN5HZYgqURwxvsO0ack8R7NPvqOyDk7rjYlaEgF+
 +Wg7YriJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ6zeRwAKCRAk1otyXVSH0LuRB/
 0TSGpX+FRHmXb0V8EBbcdsyCVNOLxzXT/tibbhYFP5GeC3NKRt0/pjk8gPKsBA6QtDc6S/lxB6/Rh2
 GxfaN1xEzAdskrXonB75YzrADUP6gF5ZslFRQa3jiczHIqHyzSs8SXDRV+njuwuPPHbyz6i3gKztGT
 EcEDa3EtP6EIQbTynEeD1fmrGKnnxffqhIhWAXQGx7BMMF1k12pOeQUDvg7cT7dezZg5nMlS+FMirB
 5dtxodGZkWlNDqDg1NmCNBYVTRxA/UNglgjv73j/pck5JacofP4kZcu4+9u7z9wTlD5AP7tkijHeRD
 vIapCj/llk7Wo1ukY9ySRMP4MZtvVK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently the mm selftests refuse to run if we don't have huge page
support but there are plenty of tests that don't depend on this feature,
relax this requirement to allow coverage on relevant systems (eg, most
32 bit arm ones).

While doing this I noticed a bug with an existing check if we're running
THP tests, the fix overlaps with the above change so is sent as part of
a series.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      selftests/mm: Fix check for running THP tests
      selftests/mm: Allow tests to run with no huge pages support

 tools/testing/selftests/mm/run_vmtests.sh | 68 +++++++++++++++++++------------
 1 file changed, 43 insertions(+), 25 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250211-kselftest-mm-no-hugepages-ee5917a170eb

Best regards,
-- 
Mark Brown <broonie@kernel.org>


