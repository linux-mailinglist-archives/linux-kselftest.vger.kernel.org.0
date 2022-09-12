Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1241D5B5678
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Sep 2022 10:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiILIlp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 04:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiILIlo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 04:41:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817A022516;
        Mon, 12 Sep 2022 01:41:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C6A4D1FB91;
        Mon, 12 Sep 2022 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662972101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yu4gesKnNyLjfpbn46QiDh9F1m6+cevrA6grXESzotc=;
        b=ToGVJgZIgbHOXfAXR8Qp9/DkLqxTBywb0q3eOn0hxS8vNVos464OURqm4ibmqkNqVebSNk
        mHuo7G9jcLrf/uGMhBXtWf3aQQ4mQvprQmWSj/ndzvN4UaQF+zJgXZ+uoc3eeJi4eznUA7
        1vYUnlOWUe36emVDozzLVVJeur2VcHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662972101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yu4gesKnNyLjfpbn46QiDh9F1m6+cevrA6grXESzotc=;
        b=3Bee2QnM7QsAA/ZEIo3n8Ph1nC8xPLEHdI2a0HXBd4NyhV9qxOUGR5yQEVj8jNhWD+9cgu
        SBN/mZ6/ub/i/9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6EE0139E0;
        Mon, 12 Sep 2022 08:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O17rJsXwHmMgMAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Mon, 12 Sep 2022 08:41:41 +0000
Date:   Mon, 12 Sep 2022 10:43:36 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     ltp@lists.linux.it, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, aneesh.kumar@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [LTP] [RFC PATCH] Hugetlb: Migrating hugetlb tests from
 libhugetlbfs
Message-ID: <Yx7xOGLqy2lVE9tI@yuki>
References: <20220908173947.17956-1-tsahu@linux.ibm.com>
 <YxsCJi8O+HmMpefq@yuki>
 <2412537e2e07ebf62fe95971a3022336cde9833a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2412537e2e07ebf62fe95971a3022336cde9833a.camel@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!
> As mentioned in the patch description, there is a conflict in license,
> That is why, I have avoided to put any of them in the header. Once
> confirmed within the community, I can add the original license here.
> (GPL2.1+) as 
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
> this says only to add code with GPL2.0+.

As far as I can tell there is no GPL2.1+ the only 2.1 version in
existence is LGPL.

GPL2.1+ usually happens to be an error when someone takes library header
with LGPL2.1+ license and removes the "Lesser" part.

However it looks like the whole libhugetlbfs is under LGPL2.1+ which
kind of makes sense for a library, but not so much for the tests since
these do not provide a library that can be linked againts at all.

-- 
Cyril Hrubis
chrubis@suse.cz
