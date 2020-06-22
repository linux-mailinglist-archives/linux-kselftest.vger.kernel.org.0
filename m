Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4556520428B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgFVVXA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 17:23:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:20567 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730460AbgFVVW7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 17:22:59 -0400
IronPort-SDR: UAoTt8pSvD3UNcfy/099cgVtTEdqJaKliGdnUlj0xcrqeEtC9hhNbkwDOF/eBNUlEFM6rFAgL+
 g3S1DRAWk3ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="131284745"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="131284745"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 14:22:58 -0700
IronPort-SDR: Ej2K4ojeT5mwx1R1iS92uXiqywEwLpq0b8Vaqa+F5Q3UZIHmuIBkxbLtWwxEqYfnoRghCpmGpn
 jd4Ctbft5cVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="275125017"
Received: from scheller-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.117])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2020 14:22:52 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     pengfei.xu@intel.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: [PATCH 0/3] selftests: tpm: fixes
Date:   Tue, 23 Jun 2020 00:20:19 +0300
Message-Id: <20200622212034.20624-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A few fixes for tools/testing/selftests/tpm.

Jarkko Sakkinen (3):
  Revert "tpm: selftest: cleanup after unseal with wrong auth/policy
    test"
  selftests: tpm: Use 'test -e' instead of 'test -f'
  selftests: tpm: Use /bin/sh instead of /bin/bash

 tools/testing/selftests/tpm2/test_smoke.sh | 9 ++-------
 tools/testing/selftests/tpm2/test_space.sh | 4 ++--
 2 files changed, 4 insertions(+), 9 deletions(-)

-- 
2.25.1

