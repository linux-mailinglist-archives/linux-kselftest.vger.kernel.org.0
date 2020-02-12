Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8352515A4BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 10:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgBLJ2E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 04:28:04 -0500
Received: from foss.arm.com ([217.140.110.172]:57894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbgBLJ2E (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 04:28:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E75D430E;
        Wed, 12 Feb 2020 01:28:03 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2143F6CF;
        Wed, 12 Feb 2020 01:28:02 -0800 (PST)
Date:   Wed, 12 Feb 2020 09:28:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Will Deacon <will.deacon@arm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 6/7] arm64, elf: Disable automatic READ_IMPLIES_EXEC
 for 64-bit address spaces
Message-ID: <20200212092800.GD488264@arrakis.emea.arm.com>
References: <20200210193049.64362-1-keescook@chromium.org>
 <20200210193049.64362-7-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210193049.64362-7-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 10, 2020 at 11:30:48AM -0800, Kees Cook wrote:
> With arm64 64-bit environments, there should never be a need for automatic
> READ_IMPLIES_EXEC, as the architecture has always been execute-bit aware
> (as in, the default memory protection should be NX unless a region
> explicitly requests to be executable).
> 
> Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
