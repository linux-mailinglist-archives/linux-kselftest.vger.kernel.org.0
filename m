Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287915AE574
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 12:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbiIFKhb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 06:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiIFKha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 06:37:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03FD50054;
        Tue,  6 Sep 2022 03:37:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86124B8169E;
        Tue,  6 Sep 2022 10:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7504C433C1;
        Tue,  6 Sep 2022 10:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662460647;
        bh=BuxP8jb9h9jN0GwTnwe4RVFoi8sw11ZHMZvZH1y85ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOXUAO02eBSo6akp7bs6auFNRuH/3OjhChGKIBZl00SaSPNBFAsHHE7IVnRan+Rpt
         5Y091I+Igj9nKbB78xXfw4sNs2tsYmaobrsA5fUERV60piERPeJNh+ZH6v1beZnHbq
         ymY9BsSkfPSYaE7n2Gg+5mwvE+QVn7G51oZfWRh4ZNeTM1mL7HY0QGDGrMGlXW5jXL
         oT+VpStV3zdKqGazFJWgby5CVvWGnFy5leod+8a/K1ed1qn78Artd3pypLY9JzkItB
         fKPOGYnjQmbhOLjI7OZq+vbjvXJ9zUncgvaby+BVS0hS/HP0ZyE0u1t38nITrci0O6
         8MbKtlWIA17PQ==
Date:   Tue, 6 Sep 2022 13:37:23 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v16 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and define KEY_LOOKUP_ALL
Message-ID: <Yxci4yrV5OcMnTNi@kernel.org>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
 <20220905143318.1592015-6-roberto.sassu@huaweicloud.com>
 <YxZsbLIAcR4/bScc@kernel.org>
 <394ed3b5f96afd3cf39e99675be1a32c89c8080d.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <394ed3b5f96afd3cf39e99675be1a32c89c8080d.camel@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 06, 2022 at 09:08:23AM +0200, Roberto Sassu wrote:
> On Tue, 2022-09-06 at 00:38 +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 05, 2022 at 04:33:11PM +0200, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > In preparation for the patch that introduces the
> > > bpf_lookup_user_key() eBPF
> > > kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be
> > > able to
> > > validate the kfunc parameters. Add them to enum key_lookup_flag, so
> > > that
> > > all the current ones and the ones defined in the future are
> > > automatically
> > > exported through BTF and available to eBPF programs.
> > > 
> > > Also, add KEY_LOOKUP_ALL to the enum, to facilitate checking
> > > whether a
> > > variable contains only defined flags.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > You should remove ack if there is any substantial change.
> 
> Yes, sorry. I thought you were fine with the change due to:
> 
> https://lore.kernel.org/bpf/YxF4H9MTDj+PnJ+V@kernel.org/

It was the documentation part, not really the enum change.

BR, Jarkko
