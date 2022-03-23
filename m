Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E484E4E5081
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 11:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiCWKlx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 06:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiCWKlx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 06:41:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB9A66622;
        Wed, 23 Mar 2022 03:40:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 41AF11F37F;
        Wed, 23 Mar 2022 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648032022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5NU/C6p8WEkJ19dl/vKk9SKF9BYMvL6KkJEgBFkRyA=;
        b=RLnV6fiKONXomeCaf7Ul3bMdB8J9ZnoYiQHMukkB3srT4RUf8bFcSLnKzUf+zJWROTJSUe
        Pl2lZGRWXDyr4H6snqXhYysgPcYpop4hSOcwif0tfFhCS180ZIq1pEcabOz0mDgCEyq4gS
        buDZQLypgb5oPEw7PaQ3SKEf0whZcJw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7184013B9C;
        Wed, 23 Mar 2022 10:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ilx3GhX5OmLaTgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 23 Mar 2022 10:40:21 +0000
Date:   Wed, 23 Mar 2022 11:40:20 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC v3 1/8] gpu: rfc: Proposal for a GPU cgroup controller
Message-ID: <20220323104020.GI8477@blackbody.suse.cz>
References: <20220309165222.2843651-1-tjmercier@google.com>
 <20220309165222.2843651-2-tjmercier@google.com>
 <20220321173726.GA9640@blackbody.suse.cz>
 <CABdmKX10jqubJr49JENaHpFnqHV88+Fb7iNZNH4T1Cy7n9y=ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX10jqubJr49JENaHpFnqHV88+Fb7iNZNH4T1Cy7n9y=ag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 22, 2022 at 08:41:55AM -0700, "T.J. Mercier" <tjmercier@google.com> wrote:
> So "total" is used twice here in two different contexts.
> The first one is the global "GPU" cgroup context. As in any buffer
> that any exporter claims is a GPU buffer, regardless of where/how it
> is allocated. So this refers to the sum of all gpu buffers of any
> type/source. An exporter contributes to this total by registering a
> corresponding gpucg_device and making charges against that device when
> it exports.
> The second one is in a per device context. This allows us to make a
> distinction between different types of GPU memory based on who
> exported the buffer. A single process can make use of several
> different types of dma buffers (for example cached and uncached
> versions of the same type of memory), and it would be useful to have
> different limits for each. These are distinguished by the device name
> string chosen when the gpucg_device is first registered.

So is this understanding correct?

(if there was an analogous line in gpu.memory.current to gpu.memory.max)
	$ cat gpu.memory.current
	total T
	dev1  d1
	...
	devN  dn

T = Σ di + RAM_backed_buffers

and that some of RAM_backed_buffers may be accounted also in
memory.current (case by case, depending on allocator).

Thanks,
Michal

