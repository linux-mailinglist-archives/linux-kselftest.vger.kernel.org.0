Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E2E667DC2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 19:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjALSSa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 13:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbjALSSB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 13:18:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB1CFA;
        Thu, 12 Jan 2023 09:48:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7429A620DD;
        Thu, 12 Jan 2023 17:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6954CC433F0;
        Thu, 12 Jan 2023 17:48:52 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kselftest/arm64: syscall-abi fix and enhancements
Date:   Thu, 12 Jan 2023 17:48:50 +0000
Message-Id: <167354570430.3643775.4806388160567980232.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223-arm64-syscall-abi-sme-only-v1-0-4fabfbd62087@kernel.org>
References: <20221223-arm64-syscall-abi-sme-only-v1-0-4fabfbd62087@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 27 Dec 2022 13:06:35 +0000, Mark Brown wrote:
> The first patch here is a fix which should ideally be sent as such,
> currently the program will hang on architecturally valid systems which
> implement SME but not 128 bit vector lengths.  The remaining patches
> are general enhancements, including coverage for the SME ABI on SME only
> systems.
> 
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/4] kselftest/arm64: Fix syscall-abi for systems without 128 bit SME
      https://git.kernel.org/arm64/c/97ec597b26df
[2/4] kselftest/arm64: Only enumerate VLs once in syscall-abi
      https://git.kernel.org/arm64/c/fae491e52cc2
[3/4] kselftest/arm64: Verify SME only ABI in syscall-abi
      https://git.kernel.org/arm64/c/024e4a155874
[4/4] kselftest/arm64: Only enumerate power of two VLs in syscall-abi
      https://git.kernel.org/arm64/c/10f326fbb458

-- 
Catalin

