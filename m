Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD043122745
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2019 10:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLQJCN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Dec 2019 04:02:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:56366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfLQJCM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Dec 2019 04:02:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E81F2AE17;
        Tue, 17 Dec 2019 09:02:10 +0000 (UTC)
Date:   Tue, 17 Dec 2019 10:02:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com, shuah@kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: livepatch: Fix it to do root uid check and
 skip
Message-ID: <20191217090210.ky3il3qu4jkr2vaa@pathway.suse.cz>
References: <20191216191840.15188-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216191840.15188-1-skhan@linuxfoundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 2019-12-16 12:18:40, Shuah Khan wrote:
> livepatch test configures the system and debug environment to run
> tests. Some of these actions fail without root access and test
> dumps several permission denied messages before it exits.
> 
> Fix test-state.sh to call setup_config instead of set_dynamic_debug
> as suggested by Petr Mladek <pmladek@suse.com>
> 
> Fix it to check root uid and exit with skip code instead.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Shuah, I assume that you will push this fix via linux-kselftest tree.
Please, tell us if you have other preference.

Best Regards,
Petr
