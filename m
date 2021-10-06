Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB30942424C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 18:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhJFQNX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 12:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238744AbhJFQNW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 12:13:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77B5161154;
        Wed,  6 Oct 2021 16:11:29 +0000 (UTC)
Date:   Wed, 6 Oct 2021 17:11:26 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: arm64: Add coverage of ptrace flags for SVE
 VL inheritance
Message-ID: <YV3KrmEwXRi51qCi@arm.com>
References: <20211005123537.976795-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005123537.976795-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 05, 2021 at 01:35:37PM +0100, Mark Brown wrote:
> Add a test that covers enabling and disabling of SVE vector length
> inheritance via the ptrace interface.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(I guess this will go in via the arm64 tree)
