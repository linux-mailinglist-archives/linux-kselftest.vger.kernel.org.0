Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5A13A2D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 09:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgANITr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 03:19:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:52902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANITr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 03:19:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2C5AFAC6E;
        Tue, 14 Jan 2020 08:19:45 +0000 (UTC)
Date:   Tue, 14 Jan 2020 09:19:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>, shuah@kernel.org
Cc:     jpoimboe@redhat.com, jikos@kernel.org, joe.lawrence@redhat.com,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/livepatch: Trivial cleanups
Message-ID: <20200114081944.ikq77zsaiu52jbci@pathway.suse.cz>
References: <20200113124907.11086-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113124907.11086-1-mbenes@suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 2020-01-13 13:49:05, Miroslav Benes wrote:
> Two trivial cleanups after recent changes in selftests/livepatch. Based
> on "next" branch of Shuah's kselftest tree.
> 
> Miroslav Benes (2):
>   selftests/livepatch: Replace set_dynamic_debug() with setup_config()
>     in README
>   selftests/livepatch: Remove unused local variable in
>     set_ftrace_enabled()

For the entire series:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Shuah, would you like to take it via your selftest tree, please?

Best Regards,
Petr
