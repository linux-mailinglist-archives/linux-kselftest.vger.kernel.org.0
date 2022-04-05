Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B6F4F54F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 07:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiDFFWw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Apr 2022 01:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587547AbiDFAJi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Apr 2022 20:09:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B549DE08E;
        Tue,  5 Apr 2022 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s5Rv2jt7aGLImfLJIiM/5w3K8YUbSOEx+pvCk6I5VMo=; b=rqdoUew930ZZ6zrAnlfvmOF/zf
        +YntEDiQq+lDqmtSifeD/BGDKf4g7GkHYLxudkmzdyK5cgH/wZucpnSc1cOEeqX5tzdZylyEm9uz5
        KjdjRJUUJa9gUj9572C6PlpVQLKxTlLKuASQa0lhQMLBp52OQqySbhM/BMq/qghF0J67yro+frIqg
        XoDZgXOLgGwC3tfbvt999mOTUy6LqjcaDRWq7nkQZS2B3zJXHLy8ItBQFTzk4vxBpz7SFXJ3cmjCe
        SB/I/ptIkVnavZf3lWoOGDw3MGZDfUUipM9KeUyy8WAfhHKBIIH3x+GfmL+nyBA2iw4nUlGS8cNsW
        Tu+LgHDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbrjU-0077Ix-P6; Tue, 05 Apr 2022 22:33:04 +0000
Date:   Tue, 5 Apr 2022 23:33:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftest/vm clarify error statement in gup_test
Message-ID: <YkzDoBUAhydtvnR0@casper.infradead.org>
References: <20220405214809.3351223-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405214809.3351223-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 05, 2022 at 09:48:09PM +0000, Sidhartha Kumar wrote:
> -		perror("open");
> -		exit(1);
> +		switch (errno) {
> +		case EACCES:
> +			if (getuid())
> +				printf("Please run this test as root\n");

Shouldn't all these be fprintf(stderr, ...); ?

