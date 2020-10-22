Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCF295961
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508727AbgJVHkj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 03:40:39 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:3351 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508725AbgJVHkj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 03:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603352439; x=1634888439;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=i+r5byucLjYXAdWulfH06tMwuc+8U15rfQaqQy4BW4s=;
  b=SnZS0dU31h3EzR1OHLvSDZpGeGyBj84lEkkW/oFHwDOkpuhOYI3gCdH/
   oGa29Ss8a2M6uRY/Un8v92ZUTRWIObneq1lmbua35OSN7f9CTFnZzlvcs
   HA+CzjBdiuXDyHF4DldYr2xIzgLlx0mxhzzgWn/g8UUm0oh7HGtWDTxNv
   E=;
X-IronPort-AV: E=Sophos;i="5.77,404,1596499200"; 
   d="scan'208";a="79115578"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Oct 2020 07:40:32 +0000
Received: from EX13D31EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 32962A21E8;
        Thu, 22 Oct 2020 07:40:29 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 22 Oct 2020 07:40:26 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.de>, <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] kunit: tool: Respect '.kunitconfig' in '--build_dir'
Date:   Thu, 22 Oct 2020 09:40:09 +0200
Message-ID: <20201022074011.1990-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D38UWB003.ant.amazon.com (10.43.161.178) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This patchset makes kunit tool to respect '.kunitconfig' under the
'--build_dir'.

Revision History
================

From v1
(https://lore.kernel.org/linux-kselftest/20201012102621.32226-2-sjpark@amazon.com/)
- Rebase on master branch of linus' tree (Not a clean rebase)
- Add 'Reviewed-by: Brendan Higgins <brendanhiggins@google.com>' in
  second patch

SeongJae Park (2):
  kunit: tool: Respect '.kunitconfig' in 'build_dir'
  kunit: tool: Mark 'kunittest_config' as constant again

 tools/testing/kunit/kunit.py        | 28 +++++++++++++++-------------
 tools/testing/kunit/kunit_kernel.py |  6 +++---
 2 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.17.1

