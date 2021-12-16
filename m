Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A572B476D64
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 10:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhLPJ2m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 04:28:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60974 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbhLPJ2k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 04:28:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E869621135;
        Thu, 16 Dec 2021 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639646918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fGxktS/Uc4QdkNKSXK/IVadOzTG1ebMs/QUmVV6nIcE=;
        b=Eh2Wx8s9jDwfC6jxKZuaZRo24mG2IrIk9796h9H2/iwEim4E06TJFI8j6yq9/wyc9rjpJo
        396WeJCIzR7D9qq7Fr4tJgnwzwqPCQ6m9OgWHc/zxKAv52j9ARDUZxGkKQjCS636XLM66F
        Tp76ek5AjK/Gkf8uXf/sx+eEV3Povs0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AABE813C1F;
        Thu, 16 Dec 2021 09:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y/wQKcYGu2FtYQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 16 Dec 2021 09:28:38 +0000
Date:   Thu, 16 Dec 2021 10:28:37 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v9 3/7] cgroup/cpuset: Refining features and constraints
 of a partition
Message-ID: <20211216092837.GB46450@blackbody.suse.cz>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-4-longman@redhat.com>
 <20211215144944.GE16798@blackbody.suse.cz>
 <98887e63-51de-f5ad-8fb8-56269aaf4bcf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98887e63-51de-f5ad-8fb8-56269aaf4bcf@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 15, 2021 at 11:29:41AM -0500, Waiman Long <longman@redhat.com> wrote:
> There are additional checks for the member to partition transition which
> requires that the target cpuset shouldn't have child cpuset.

Ah, I forgot the transition condition no. 4 will apply here. Clear.

So, currently full bottom up + top down walk is needed in (rare?) case
the switch from root partition to member and back.

> That prevents the recovering of a invalid partition root under a
> member cpuset. We could certainly remove that restriction by adding
> additional code as well as additional tests to verify it works. I
> haven't done that simply to avoid adding more complexity to the
> current code.

I agree this restriction can be lifted later independently when the rest
settles.  (It's not so different from controllers disabling on the
unified hierarchy after all.)


Thanks,
Michal

