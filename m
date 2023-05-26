Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7059B712AEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 18:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbjEZQoB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 12:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjEZQoA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 12:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB783D9;
        Fri, 26 May 2023 09:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B32A617A1;
        Fri, 26 May 2023 16:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE30C433EF;
        Fri, 26 May 2023 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685119438;
        bh=Z/ch5nJkQyaxrmN1rRuD6Zg08kQpZg1acmK+3khx85E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hT82lZ1GYXwKZ3QyfJyhu12TOwN6oQstsGuNbmlXcwBuDDULVbbZ1dh3lPvrex2DD
         RF9Ig7Bx4mdzowwgjgWTQkXt9Xagfua8Xh9YmwXQTdHqkztG4L66CaHFmOoXcIJcDJ
         S/JFEo91ouORTBBrIbDHSZe2CZc1ZIlgiOvUrDlE=
Date:   Fri, 26 May 2023 17:43:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, yhs@fb.com, eddyz87@gmail.com, sdf@google.com,
        error27@gmail.com, iii@linux.ibm.com, memxor@gmail.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
Message-ID: <2023052647-tacking-wince-85c5@gregkh>
References: <20230320005258.1428043-1-sashal@kernel.org>
 <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
 <ZBiAPngOtzSwDhFz@kroah.com>
 <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
 <CAN+4W8j5qe6p3YV90g-E0VhV7AmYyAvt0z50dfDSombbGghkww@mail.gmail.com>
 <2023041100-oblong-enamel-5893@gregkh>
 <CAN+4W8hmSgbb-wO4da4A=6B4y0oSjvUTTVia_0PpUXShP4NX4Q@mail.gmail.com>
 <2023052435-xbox-dislike-0ab2@gregkh>
 <CAN+4W8iMcwwVjmSekZ9txzZNxOZ0x98nBXo4cEoTU9G2zLe8HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+4W8iMcwwVjmSekZ9txzZNxOZ0x98nBXo4cEoTU9G2zLe8HA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 06:04:43PM +0100, Lorenz Bauer wrote:
> On Wed, May 24, 2023 at 5:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Great, any specific commits that fix this issue would be appreciated to
> > be pointed at so we can apply them.
> 
> The problem was introduced by commit f4b8c0710ab6 ("selftests/bpf: Add
> verifier test for release_reference()") in your tree. Seems like
> fixup_map_ringbuf was introduced in upstream commit 4237e9f4a962
> ("selftests/bpf: Add verifier test for PTR_TO_MEM spill") but that
> wasn't backported.

So what tree(s) does this need to be backported to?  I'm confused, this
is a 6.2 email thread which is long end-of-life.

> To restate my original question: how can we avoid breaking BPF
> selftests? From personal experience this happens somewhat regularly.

It can be avoided by people testing and letting me know when things
break :)

thanks,

greg k-h
