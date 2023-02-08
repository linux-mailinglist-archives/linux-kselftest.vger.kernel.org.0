Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4925E68E95A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 08:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBHHy3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 02:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBHHy3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 02:54:29 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD7D25294;
        Tue,  7 Feb 2023 23:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675842867; x=1707378867;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yc5gczRuyEW9BjeTEqBRpxEHpjo6TawCP6phTo9XQlQ=;
  b=mgSXXkfUbsL0LgC+qt9+9gzBwxNp1UO2YRFliVzalDRgRQaG7sZdaVNx
   alxb1pPdVxPzqucQyg61l72ptWan6J9YPJdArxjOB8Q1NQWBtEnd3daWi
   g8ffUYpXLXFLjWlt5vs7kslbHrEz0zwAfH4Ig9jyuLArYeI2KYKSklQAM
   RvHNHO2w4AZZV0yz0NBzGGrOpl6YutsvRu//ISKlOyZztIudNbkUVxw1V
   RH+os5waCsMqlxySvxx/pANcFq/pWoaYicikadBCUT15DqHdxaPDL2+GS
   db2K55yso7lnWndpkkjDTDopp1y1Yno+i/poYvPM7eVwE6dnrAUm2W/4k
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="392132886"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="392132886"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 23:54:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="669094442"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="669094442"
Received: from jstelter-mobl.ger.corp.intel.com ([10.252.38.39])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 23:54:24 -0800
Date:   Wed, 8 Feb 2023 09:54:19 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v6 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
In-Reply-To: <OSZPR01MB6328AE8F77449F7D6C7DE8958BD89@OSZPR01MB6328.jpnprd01.prod.outlook.com>
Message-ID: <c3acfc41-44f8-263e-379e-f8825194a6e@linux.intel.com>
References: <20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com> <20230131054655.396270-5-tan.shaopeng@jp.fujitsu.com> <83e1de31-b448-1a51-ba39-faec794694f@linux.intel.com> <OSZPR01MB6328AE8F77449F7D6C7DE8958BD89@OSZPR01MB6328.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 8 Feb 2023, Shaopeng Tan (Fujitsu) wrote:
> > On Tue, 31 Jan 2023, Shaopeng Tan wrote:
> > 
> > > After creating a child process with fork() in CAT test, if an error
> > > occurs or a signal such as SIGINT is received, the parent process will
> > > be terminated immediately, and therefor the child process will not be
> > > killed and also resctrlfs is not unmounted.
> > >
> > > There is a signal handler registered in CMT/MBM/MBA tests, which kills
> > > child process, unmount resctrlfs, cleanups result files, etc., if a
> > > signal such as SIGINT is received.
> > >
> > > Commonize the signal handler registered for CMT/MBM/MBA tests and
> > > reuse it in CAT too.
> > >
> > > To reuse the signal handler, make the child process in CAT wait to be
> > > killed by parent process in any case (an error occurred or a signal
> > > was received), and when killing child process use global bm_pid
> > > instead of local bm_pid.
> > >
> > > Also, since the MBA/MBA/CMT/CAT are run in order, unregister the
> > > signal handler at the end of each test so that the signal handler
> > > cannot be inherited by other tests.
> > >
> > > Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> > > ---
> > 
> > >  	if (bm_pid == 0) {
> > >  		/* Tell parent that child is ready */
> > >  		close(pipefd[0]);
> > >  		pipe_message = 1;
> > >  		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
> > > -		    sizeof(pipe_message)) {
> > > -			close(pipefd[1]);
> > > +		    sizeof(pipe_message))
> > > +			/*
> > > +			 * Just print the error message.
> > > +			 * Let while(1) run and wait for itself to be killed.
> > > +			 */
> > >  			perror("# failed signaling parent process");
> > 
> > If the write error is ignored here, won't it just lead to parent hanging forever
> > waiting for the child to send the message through the pipe which will never
> > come?
> 
> If the write error is ignored here, the pipe will be closed by "close(pipefd[1]);" and child process will wait to be killed by "while(1)".
> ---
> -			return errno;
> -		}
> 
>  		close(pipefd[1]);
>  		while (1)
> ---
> 
> If all file descriptors referring to the write end of a pipe have been closed, 
> then an attempt to read(2) from the pipe will see end-of-file (read(2) will return 0).
> Then, "perror("# failed reading from child process");" occurs.
> ---
>         } else {
>                 /* Parent waits for child to be ready. */
>                 close(pipefd[1]);
>                 pipe_message = 0;
>                 while (pipe_message != 1) {
>                         if (read(pipefd[0], &pipe_message,
>                                  sizeof(pipe_message)) < sizeof(pipe_message)) {
>                                 perror("# failed reading from child process");
>                                 break;
>                         }
>                 }
>                 close(pipefd[0]);
>                 kill(bm_pid, SIGKILL);
>                 signal_handler_unregister();
>         }

Ah, indeed read() will pick up the close event. So your code seem fine 
after all.

-- 
 i.

