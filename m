Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8AF7ABA
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2019 19:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfKKSZ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Nov 2019 13:25:58 -0500
Received: from foss.arm.com ([217.140.110.172]:49022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfKKSZ5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Nov 2019 13:25:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E2421FB;
        Mon, 11 Nov 2019 10:25:57 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B31A3F534;
        Mon, 11 Nov 2019 10:25:56 -0800 (PST)
Date:   Mon, 11 Nov 2019 18:25:54 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] kselftest: arm64: fix spelling mistake "contiguos"
 -> "contiguous"
Message-ID: <20191111182553.GB60539@arrakis.emea.arm.com>
References: <20191111091236.37165-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111091236.37165-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 11, 2019 at 09:12:36AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Queued for 5.5. Thanks.

-- 
Catalin
