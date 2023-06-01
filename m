Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9911D7196F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjFAJav (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjFAJau (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D576F97;
        Thu,  1 Jun 2023 02:30:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6874D64289;
        Thu,  1 Jun 2023 09:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90B5C433D2;
        Thu,  1 Jun 2023 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685611848;
        bh=nxbo84IOlR/x0Mz0ilNcc5GVTrThNltXID8GFyg0kV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/Om7C47aKLwfCnQvKQLwfE92UAcFrdtBziJesACLDyuxFZbL2SH+ieZe7wvJwKaI
         ZIO2Y1t7vwYap3H2A538MX4KqKwGgAWnAYlo5cprz/lqi3s3sVsK4Vxi/yDKgkjXnq
         tSbn6bUQx8RTOfLkeGX4SOG3uSO+cqdEwrivxA4Z2BDqww7DtmvLnpIrn3Ch11MYTO
         17dm324W2U6X8F4qO13LJ4tyxXj9u62Jr6cFw0YvG7DAGQaJavGEGF7VHfRtD5t8F4
         HVgwd2r5Y1W97eoukoW4DhfAN0p8dZeIFbefrKdhwwNBpXwRhiPXnX4Hgs+YzdajB0
         paOxW+9Iy2ZJw==
Date:   Thu, 1 Jun 2023 05:30:47 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.3 07/67] selftests/ftrace: Improve integration
 with kselftest runner
Message-ID: <ZHhlR+bZO7mOGKVf@sashalap>
References: <20230525183144.1717540-1-sashal@kernel.org>
 <20230525183144.1717540-7-sashal@kernel.org>
 <276d5748-40c4-43b4-9241-9d30a5a64d0e@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <276d5748-40c4-43b4-9241-9d30a5a64d0e@sirena.org.uk>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 26, 2023 at 04:23:33PM +0100, Mark Brown wrote:
>On Thu, May 25, 2023 at 02:30:44PM -0400, Sasha Levin wrote:
>> From: Mark Brown <broonie@kernel.org>
>>
>> [ Upstream commit dbcf76390eb9a65d5d0c37b0cd57335218564e37 ]
>>
>> The ftrace selftests do not currently produce KTAP output, they produce a
>> custom format much nicer for human consumption. This means that when run in
>> automated test systems we just get a single result for the suite as a whole
>> rather than recording results for individual test cases, making it harder
>> to look at the test data and masking things like inappropriate skips.
>
>This seems to be very much a new feature rather than a fix?

Yup, I'll drop it. Thanks!

-- 
Thanks,
Sasha
