Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90174A6401
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 19:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbiBASfj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 13:35:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39956 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241814AbiBASfi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 13:35:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D1261575
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Feb 2022 18:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB41FC340EB;
        Tue,  1 Feb 2022 18:35:36 +0000 (UTC)
Date:   Tue, 1 Feb 2022 18:35:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Remove local ARRAY_SIZE() definitions
Message-ID: <Yfl9dTbMPLqaT/rN@arm.com>
References: <20220124171748.2195875-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124171748.2195875-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 24, 2022 at 05:17:48PM +0000, Mark Brown wrote:
> An ARRAY_SIZE() has been added to kselftest.h so remove the local versions
> in some of the arm64 selftests.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
