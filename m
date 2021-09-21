Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E4F413827
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Sep 2021 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhIUROY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Sep 2021 13:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhIUROY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Sep 2021 13:14:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9980E61002;
        Tue, 21 Sep 2021 17:12:54 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-kselftest@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] kselftest/arm64: signal: Skip tests if required features are missing
Date:   Tue, 21 Sep 2021 18:12:52 +0100
Message-Id: <163224436826.589986.5902973582003476278.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920121228.35368-1-cristian.marussi@arm.com>
References: <20210920121228.35368-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 20 Sep 2021 13:12:28 +0100, Cristian Marussi wrote:
> During initialization of a signal testcase, features declared as required
> are properly checked against the running system but no action is then taken
> to effectively skip such a testcase.
> 
> Fix core signals test logic to abort initialization and report such a
> testcase as skipped to the KSelfTest framework.

Applied to arm64 (for-next/fixes), thanks!

[1/1] kselftest/arm64: signal: Skip tests if required features are missing
      https://git.kernel.org/arm64/c/0e3dbf765fe2

-- 
Catalin

