Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33D3DD39A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 12:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhHBK1K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 06:27:10 -0400
Received: from foss.arm.com ([217.140.110.172]:33146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhHBK1K (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 06:27:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE8FDD6E;
        Mon,  2 Aug 2021 03:27:00 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 048C63F70D;
        Mon,  2 Aug 2021 03:26:59 -0700 (PDT)
Date:   Mon, 2 Aug 2021 11:25:29 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/4] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210802102517.GA25258@arm.com>
References: <20210729151518.46388-1-broonie@kernel.org>
 <20210729151518.46388-4-broonie@kernel.org>
 <20210729160642.GP1724@arm.com>
 <20210729173411.GT4670@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729173411.GT4670@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 29, 2021 at 06:34:11PM +0100, Mark Brown wrote:
> On Thu, Jul 29, 2021 at 05:06:42PM +0100, Dave Martin wrote:
> > On Thu, Jul 29, 2021 at 04:15:17PM +0100, Mark Brown wrote:
> 
> > > +	child = fork();
> > > +	if (child == -1) {
> > > +		ksft_print_msg("fork() failed: %d (%s)\n",
> > > +			       errno, strerror(errno));
> > > +		close(pipefd[0]);
> > > +		close(pipefd[1]);
> > > +		return -1;
> 
> > Since nothing reopens pipefd[0] or pipefd[1], you could also follow the
> > "goto out" convention and just (re)close both fds at the end, rather
> > than having to repeat the close() multiple times.  But it works as-is.
> 
> I find that when fork() gets involved that starts to get confusing since
> you have multiple contexts/control flows around and working out which
> cleanup path goes where is more of the issue.

Ack, the other option would be to factor out the child stuff into a
separate function, but this doesn't quite seem worth it here.

Although the code seemed a bit repetitive, it is at least clear in its
current form, so I don't have a strong view.

> 
> > > +		if (!WIFEXITED(ret)) {
> > > +			ksft_print_msg("child exited abnormally\n");
> > > +			close(pipefd[0]);
> > > +			return -1;
> > > +		}
> 
> > The WEXITSTATUS() check could go outside the loop.
> 
> OTOH I find that logically it's part of working out what happened with
> the child which is what the loop body is doing.  Anyway I changed to the
> do/while you suggested.

That's a reasonable position, but thinking about it a bit more, there's
not really any loop at all here.

There definitely is an unwaited-for child and we don't pass WHONANG to
wait(), so it will either return the child pid, or fail.

Without WUNTRACED or similar, the child must terminate to wake up the
wait().

So is this just a matter of

	pid = wait(&ret);
	if (pid == -1) {
		/* barf */
	}
	assert(pid == child);

	if (!WIFEXITED(ret)) {
		/* barf */
	}

	if (WEXITSTATUS(ret) != 0) {
		/* barf */
	}

	/* parse child's stdout etc. */

> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.

Hmmm, usually I at least try to do that, but I did seem to leave rather
a lot of trailing junk that time.

(Working out which context is relevant is not always an exact science,
but in this case, it looks like I just forgot.)

Cheers
---Dave 
