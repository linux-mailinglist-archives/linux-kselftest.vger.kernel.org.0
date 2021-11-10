Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14244C67F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 18:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhKJRyw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 12:54:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37358 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhKJRyw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 12:54:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53FC31FDC1;
        Wed, 10 Nov 2021 17:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636566723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvAGaaEk28BI3M4YLWXsJxHLc6pSST1USyqVE8D7V0U=;
        b=dy+BELMi2a26LP+9/WoG7sygm2jQaK0aPhymhLAFozDgSa+Om7lHTdxBL3zlvpx5ad173n
        sizdEvd6MbtzonKUrDJib73uc0TRbxg0+HaMJZh1oiVVnGxDBJh8zp1iolsBx61zKTwd6p
        zZpBowSmOeBbvUhfLAawN85O+V7o5zQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16D6313C7D;
        Wed, 10 Nov 2021 17:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iYcEBcMGjGGVLwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 10 Nov 2021 17:52:03 +0000
Date:   Wed, 10 Nov 2021 18:52:01 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        "Moessbauer, Felix" <felix.moessbauer@siemens.com>,
        "longman@redhat.com" <longman@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "guro@fb.com" <guro@fb.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>
Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
Message-ID: <20211110175201.GA51149@blackbody.suse.cz>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211110111357.17617-1-felix.moessbauer@siemens.com>
 <20211110135653.GD20566@blackbody.suse.cz>
 <AM9PR10MB4869C14EAE01B87C0037BF6A89939@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
 <20211110161020.GA20101@fuller.cnet>
 <c1e94031-a179-dc72-e5ee-3f8197bea492@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1e94031-a179-dc72-e5ee-3f8197bea492@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 10, 2021 at 05:15:41PM +0100, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Is there pthread_attr_setcgroup_np()?

If I'm not mistaken the 'p' in pthreads stands for POSIX and cgroups are
Linux specific so you won't find that (unless you implement that
yourself). ¯\_(ツ)_/¯

Michal
