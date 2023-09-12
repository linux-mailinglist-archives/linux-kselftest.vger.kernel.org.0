Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1775779D751
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 19:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjILRMt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 13:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbjILRMp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 13:12:45 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A16481720;
        Tue, 12 Sep 2023 10:12:40 -0700 (PDT)
Received: from DESKTOP-4OLSCEK. (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 53D2E212BC14;
        Tue, 12 Sep 2023 10:12:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53D2E212BC14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694538759;
        bh=h6VnK4CFQH+xSRKq/T+c2LRxcbNukp7Ia0Dn9Y5C0Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WG41fQ5setfYxTQEQvoEHsCEaI/JaUCgy3kETvWDYa1S0UvOBzVz45pOZTjtkq1xM
         Dc8Fv1tRtzVPX7UWLPG+mY2k+bn0XU+icHF3sIjLJPxLy7eHg0KR54ZPjsUvT60MLG
         84Zw6f0Pn+7KYjtMMqEh7kSbzn6Exwp6UdhpTCYM=
Date:   Tue, 12 Sep 2023 10:12:34 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Brown <broonie@kernel.org>, shuah@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, naresh.kamboju@linaro.org,
        anders.roxell@linaro.org, arnd@arndb.de
Subject: Re: [PATCH v2] selftests/user_events: Fix failures when user_events
 is not installed
Message-ID: <20230912171234.GA3704-beaub@linux.microsoft.com>
References: <20230908201916.562-1-beaub@linux.microsoft.com>
 <29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk>
 <20230908212712.211a4964@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908212712.211a4964@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 08, 2023 at 09:27:12PM -0400, Steven Rostedt wrote:
> On Sat, 9 Sep 2023 00:33:05 +0100
> Mark Brown <broonie@kernel.org> wrote:
> 
> > On Fri, Sep 08, 2023 at 08:19:16PM +0000, Beau Belgrave wrote:
> > 
> > > Add common methods to detect if tracefs and user_events is enabled. If
> > > either is not enabled skip the test. If tracefs is enabled, but is not
> > > mounted, mount tracefs and fail if there were any errors. Fail if not
> > > run as root.  
> > 
> > This will leave tracefs mounted if it was not already mounted which is a
> > change to the system configuration.  While that may happen if things go
> > wrong during a test we should probably avoid actively doing this and
> > either only skip or try to umount at the end of the test if we mounted
> > ourselves.
> 
> LOL! Beau just asked me yesterday if anyone would care if the test mounted
> tracefs and left it mounted. I told him "no" as ftracetest in the selftests
> already do that.
> 
> I guess I was wrong and some people do care ;-)
> 
> -- Steve

It looks like this change got applied [1] to the fixes branch of
linux-kselftest. I can either send a V3 with this addressed or build a
patch based upon the fixes branch on top of this one to address it.

Which way do you all prefer?

Thanks,
-Beau

1. https://git.kernel.org/shuah/linux-kselftest/c/a06023a8f78d
