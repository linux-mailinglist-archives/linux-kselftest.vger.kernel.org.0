Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAD115A4AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 10:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgBLJ11 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 04:27:27 -0500
Received: from foss.arm.com ([217.140.110.172]:57820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgBLJ11 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 04:27:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14C8330E;
        Wed, 12 Feb 2020 01:27:27 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82DFD3F6CF;
        Wed, 12 Feb 2020 01:27:25 -0800 (PST)
Date:   Wed, 12 Feb 2020 09:27:23 +0000
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
Subject: Re: [PATCH v3 4/7] arm32/64, elf: Add tables to document
 READ_IMPLIES_EXEC
Message-ID: <20200212092723.GB488264@arrakis.emea.arm.com>
References: <20200210193049.64362-1-keescook@chromium.org>
 <20200210193049.64362-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210193049.64362-5-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 10, 2020 at 11:30:46AM -0800, Kees Cook wrote:
> Add tables to document the current behavior of READ_IMPLIES_EXEC in
> preparation for changing the behavior for both arm64 and arm.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
