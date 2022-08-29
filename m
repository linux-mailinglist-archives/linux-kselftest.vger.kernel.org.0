Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3A65A4C55
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiH2Mtl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 08:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiH2MsX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 08:48:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AB829C87;
        Mon, 29 Aug 2022 05:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71332B80EF3;
        Mon, 29 Aug 2022 12:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E524C433D7;
        Mon, 29 Aug 2022 12:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661776423;
        bh=BVx7YbyPMDfrYRtpBOz6+GKhJ46zqHQZiBFkpP2hkz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5uumRxhoH24u+dxOE5PNQTXrfWOPCpXPp+ngZXWVHgFu2b67Ylpp9CB+nRe/3YBf
         TUBkgCelx4d2fAo4Q74WyvGM43PpeZdKktdwXbQkwCoceJlc+tZnov1wPtznqzGNMQ
         xiKV9SnGt0gOlj3HQrgx3vlYItWCRrYAuAWcybqBVUWVlOjCwQJO5qSZq4s3x/CBg1
         ENSSVnwg/ToTp8H1Zi9maNgrcPoU0qyOpvci5nodSdsRSpQ0w9bN2Y6AadQojgQmbo
         8dkVhnGnS3YvvWz8hmHY87/o616yHrBMKbhd0juM0AFqRGVZxFOHhTHRw+tsOPYKFF
         GXjqzfKRIEqdw==
Date:   Mon, 29 Aug 2022 15:33:34 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v14 04/10] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and add flags check function
Message-ID: <YwyyHr0udrOIy7IX@kernel.org>
References: <acae432697e854748d9a44c732ec8cab807d9d46.camel@huaweicloud.com>
 <20220826091228.1701185-1-roberto.sassu@huaweicloud.com>
 <6d85d7b1f0c2341698e88bad025bd6e0b34c7666.camel@huaweicloud.com>
 <YwroKjo7IkQDepp5@kernel.org>
 <YwrpL9b3NXtjnPru@kernel.org>
 <cead9f6ad77a66425324a880bd1df389fe258d40.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cead9f6ad77a66425324a880bd1df389fe258d40.camel@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 29, 2022 at 09:25:05AM +0200, Roberto Sassu wrote:
> On Sun, 2022-08-28 at 07:03 +0300, Jarkko Sakkinen wrote:
> > On Sun, Aug 28, 2022 at 06:59:41AM +0300, Jarkko Sakkinen wrote:
> > > On Fri, Aug 26, 2022 at 11:22:54AM +0200, Roberto Sassu wrote:
> > > > On Fri, 2022-08-26 at 11:12 +0200, Roberto Sassu wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > 
> > > > > In preparation for the patch that introduces the
> > > > > bpf_lookup_user_key() eBPF
> > > > > kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to
> > > > > be
> > > > > able to
> > > > > validate the kfunc parameters.
> > > > > 
> > > > > Also, introduce key_lookup_flags_valid() to check if the caller
> > > > > set
> > > > > in the
> > > > > argument only defined flags. Introduce it directly in
> > > > > include/linux/key.h,
> > > > > to reduce the risk that the check is not in sync with currently
> > > > > defined
> > > > > flags.
> > > > > 
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > > > 
> > > > Jarkko, could you please ack it if it is fine?
> > > 
> > > So, as said I'm not really confident that a function is
> > > even needed in the first place. It's fine if there are
> > > enough call sites to make it legit.
> > 
> > And *if* a named constant is enough, you could probably
> > then just squash to the same patch that uses it, right?
> 
> Yes, the constant seems better. Maybe, I would add in the same patch
> that exports the lookup flags, since we have that.

Yeah, then it would be probably easier to review too
since it is "in the context".

BR, Jarkko
