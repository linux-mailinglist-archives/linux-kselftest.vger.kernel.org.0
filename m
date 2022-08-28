Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167EB5A3B57
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Aug 2022 06:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiH1EEL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 00:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiH1EEK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 00:04:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE5A3DF11;
        Sat, 27 Aug 2022 21:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 641C4B80AC7;
        Sun, 28 Aug 2022 04:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579ADC433C1;
        Sun, 28 Aug 2022 04:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661659446;
        bh=DV8YmkMB8DacJszyfV7gO6K0eZEBa8075fSuyzAhEwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjSMiEBdxsbtyBR2J8Q3wU41QSSonH7rUnb0LogRTdUCi3J8EbLrtQ4+MeCoizuC7
         SgcDH5oB+p/gp6LjPc40MDdV3wTcYYzmWP4cbP4N8NPSWHERH3LbW6x5uc2RY8LW4G
         FWrlwvnt7ktXVMpi3rK6I+mh3OYJ+OjE5OOdryCbqbf8q4xdEV9KPXOqf/wmGuowEg
         wZArkPzw3HkLik1UXrHcq/NkK5803acM/JjGEWMAhAPiD8/28YDUsnVUHsicnJgIyn
         k6HeB3bJQuAodQwci12EVniEmjjaQglIriaIdp2wiURm0LRC/OxPeGdZPpsd3aVao5
         PM3OqvsoSr8nQ==
Date:   Sun, 28 Aug 2022 07:03:59 +0300
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
Message-ID: <YwrpL9b3NXtjnPru@kernel.org>
References: <acae432697e854748d9a44c732ec8cab807d9d46.camel@huaweicloud.com>
 <20220826091228.1701185-1-roberto.sassu@huaweicloud.com>
 <6d85d7b1f0c2341698e88bad025bd6e0b34c7666.camel@huaweicloud.com>
 <YwroKjo7IkQDepp5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwroKjo7IkQDepp5@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 28, 2022 at 06:59:41AM +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 26, 2022 at 11:22:54AM +0200, Roberto Sassu wrote:
> > On Fri, 2022-08-26 at 11:12 +0200, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > In preparation for the patch that introduces the
> > > bpf_lookup_user_key() eBPF
> > > kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be
> > > able to
> > > validate the kfunc parameters.
> > > 
> > > Also, introduce key_lookup_flags_valid() to check if the caller set
> > > in the
> > > argument only defined flags. Introduce it directly in
> > > include/linux/key.h,
> > > to reduce the risk that the check is not in sync with currently
> > > defined
> > > flags.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > 
> > Jarkko, could you please ack it if it is fine?
> 
> So, as said I'm not really confident that a function is
> even needed in the first place. It's fine if there are
> enough call sites to make it legit.

And *if* a named constant is enough, you could probably
then just squash to the same patch that uses it, right?

If there overwhelming amount of call sites I do fully
get having a helper.

BR, Jarkko
