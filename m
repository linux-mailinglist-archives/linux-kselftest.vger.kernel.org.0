Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7D57418E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjF1Tbl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 15:31:41 -0400
Received: from nautica.notk.org ([91.121.71.147]:38782 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbjF1Tbb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 15:31:31 -0400
Received: by nautica.notk.org (Postfix, from userid 108)
        id 83007C01F; Wed, 28 Jun 2023 21:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1687980689; bh=kq+Cd3ze4IdymcmcbBkmObHA4RqjoJ5x5Sn/8OiQZFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLAUaL3zge/w0oyouSmSkjTKt4CPQh1/XcyOrs000ItkQlF5pJXSZAeQeO6S8YfFk
         FZnS3VHrFKvpzVvlebSpbtZT6JeRO6YGvIFH5oAzlGMvBV9R1OCtw3mFvj1uNO97lz
         C/08VbTIzlXtW2+3NUjk+M0zue7dwsWn0SjJPfC6WhH5B0lDCIFsWU0p5GOq/FxbgN
         8IlqzOhCjU2Zb2VHLTMVLzesAArWsD1HSyxX2Q3LkDKFMvpp5uhe/GG5QiSq4o9PEr
         XnYYdUEWHJx3fhKmocRcbKwLcM17Gi+pIm6/9UOpNQkhDVe3BaEF01J2RvrAmx6YQW
         jd97PAO36/OHw==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id ECF89C009;
        Wed, 28 Jun 2023 21:31:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1687980688; bh=kq+Cd3ze4IdymcmcbBkmObHA4RqjoJ5x5Sn/8OiQZFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EMNt9hc06DX1WRZOck1lTPJyOqIRq9yDZk7fUqoltSw8y+VnEhMBu4TKwazeDtCO1
         +l+FT3MgGR99zwdb/VjlTSTdob2EnGmbDOKDLaTKkqLDoPQiMbjInagFrVuc5VRbP5
         2rPzy6I1H4vB1GhtUJU3PhwpShEdJrNhVkgwLc7c5qt9OEh0wcCzBfPb5yXI9YO8c0
         SDT9K9Rkk6UjwbejplGA1QTjnGRz87ur7z4SbqcGp2BvnxYU5dqPIujFl/23AKcS0K
         SsTzEOX/VTG9PfBZdx0P+sG5UGOf65DUx7iHfe2EytyNFSd4gI8l5ccR/H3IHBiUvv
         rY9Ebd/9RROPg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 4821f3bd;
        Wed, 28 Jun 2023 19:31:21 +0000 (UTC)
Date:   Thu, 29 Jun 2023 04:31:05 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 3/5] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <ZJyKeeqRJxzwlMhk@codewreck.org>
References: <20221215001205.51969-1-jeffxu@google.com>
 <20221215001205.51969-4-jeffxu@google.com>
 <ZJwcsU0vI-nzgOB_@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJwcsU0vI-nzgOB_@codewreck.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dominique Martinet wrote on Wed, Jun 28, 2023 at 08:42:41PM +0900:
> If flags already has either MFD_EXEC or MFD_NOEXEC_SEAL, you don't check
> the sysctl at all.
> [...repro snipped..]
> 
> What am I missing?

(Perhaps the intent is just to force people to use the flag so it is
easier to check for memfd_create in seccomp or other LSM?
But I don't see why such a check couldn't consider the absence of a flag
as well, so I don't see the point.)


> BTW I find the current behaviour rather hard to use: setting this to 2
> should still set NOEXEC by default in my opinion, just refuse anything
> that explicitly requested EXEC.

And I just noticed it's not possible to lower the value despite having
CAP_SYS_ADMIN: what the heck?! I have never seen such a sysctl and it
just forced me to reboot because I willy-nilly tested in the init pid
namespace, and quite a few applications that don't require exec broke
exactly as I described below.

If the user has CAP_SYS_ADMIN there are more container escape methods
than I can count, this is basically free pass to root on main namespace
anyway, you're not protecting anything. Please let people set the sysctl
to what they want.

> Sure there's a warn_once that memfd_create was used without seal, but
> right now on my system it's "used up" 5 seconds after boot by systemd:
> [    5.854378] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=1 'systemd'
> 
> And anyway, older kernels will barf up EINVAL when calling memfd_create
> with MFD_NOEXEC_SEAL, so even if userspace will want to adapt they'll
> need to try calling memfd_create with the flag once and retry on EINVAL,
> which let's face it is going to take a while to happen.
> (Also, the flag has been added to glibc, but not in any release yet)
> 
> Making calls default to noexec AND refuse exec does what you want
> (forbid use of exec in an app that wasn't in a namespace that allows
> exec) while allowing apps that require it to work; that sounds better
> than making all applications that haven't taken the pain of adding the
> new flag to me.
> Well, I guess an app that did require exec without setting the flag will
> fail in a weird place instead of failing at memfd_create and having a
> chance to fallback, so it's not like it doesn't make any sense;
> I don't have such strong feelings about this if the sysctl works, but
> for my use case I'm more likely to want to take a chance at memfd_create
> not needing exec than having the flag set. Perhaps a third value if I
> cared enough...
 

-- 
Dominique Martinet | Asmadeus
