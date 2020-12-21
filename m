Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B512DFD6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Dec 2020 16:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgLUPWJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Dec 2020 10:22:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:53728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgLUPWJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Dec 2020 10:22:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608564082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zTMTGAKBseQvmQ41uSQjgUk4Eslqf5zZLakwbeM3kI=;
        b=WRbifkiATxQUCmvnYYoDdxGbpQ6sbNaWJHDEfhda/0rSWg1dn1KX1n6UOHf369yKlNgaho
        MCjf5JCp05zENv6BI6DbtPjA/Ti3BA2AN9GLZxc5J7sHxSEI5uv3R88mLi4oM4VpkTItUd
        0Ayz/QCAp3TEuaGl8HcXpVsvBetHR+U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4641CAE63;
        Mon, 21 Dec 2020 15:21:22 +0000 (UTC)
Date:   Mon, 21 Dec 2020 16:21:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        shuah@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/4] lib: test_scanf: Add tests for sscanf number
 conversion
Message-ID: <X+C9cVWKLeZZXs7w@alley>
References: <20201217180057.23786-1-rf@opensource.cirrus.com>
 <20201217180057.23786-3-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217180057.23786-3-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2020-12-17 18:00:56, Richard Fitzgerald wrote:
> Adds test_sscanf to test various number conversion cases, as
> number conversion was previously broken.
> 
> This also tests the simple_strtoxxx() functions exported from
> vsprintf.c.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
