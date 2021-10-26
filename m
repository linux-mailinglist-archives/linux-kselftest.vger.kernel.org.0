Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E70443B213
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbhJZMP6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 08:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232736AbhJZMP6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 08:15:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 161976103C;
        Tue, 26 Oct 2021 12:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635250414;
        bh=uGeTLpo0qu3n1h2jtUvkHLDzxgn66b6O4QqW8m5VBQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ufLV54Z0sifyPvhuJLBnjsGihoYAvYx1xkPEgy1wDPFXxSgp3X+2GbXbdE7O3cN+E
         Wh39T0tV5HJiu4KTbpY0wCRH5OuBIFDgWfE2Uonac7QdNMiA1+xqJW89ouY4JJYF3e
         +GeejNlR39OKuo7Y7VXfsXTAemMOoS2kkn2VBioNrf9GLxV/9UA5mW8ZX8WcnP8kQ2
         K2q8pGYXHR/VkyD8O8jS1QMpntEqH34LYajEvYdtdyi4tDNJvsN69btSeMFQI5ockM
         Lmoshd5BQ19wse2n2huHLj5XX/R3clL+ozskD/pTj/dbW3mMc2mCEtG/4Aj/mGfNd2
         ZvOrNyN3j9xbQ==
Date:   Tue, 26 Oct 2021 21:13:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, <mingo@redhat.com>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Message-Id: <20211026211331.8496340b0011127e6505b5ff@kernel.org>
In-Reply-To: <20211025221717.56daf4e8@rorschach.local.home>
References: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
        <20211018221636.47157e52@gandalf.local.home>
        <20211020112027.b01762f2adcfac99e71dcf99@kernel.org>
        <20211019223454.5da09d74@gandalf.local.home>
        <20211020115522.75f3e25247c1d30726e9b130@kernel.org>
        <20211020101659.42360147@gandalf.local.home>
        <20211021093131.affc348280aba040f76f769e@kernel.org>
        <20211025221717.56daf4e8@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 25 Oct 2021 22:17:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 21 Oct 2021 09:31:31 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > > +# Stop tracing while reading the trace file by default, to prevent
> > > > +# the test results while checking it and to avoid taking a long time
> > > > +# to check the result.
> > > > +    [ -f options/pause-on-trace ] && echo 1 > options/pause-on-trace
> > > > +  
> > > 
> > > Is there a way we can save the previous setting and put it back on reset?  
> > 
> > No, since each testcase must be run under the clean state. Would we need to
> > recover the settings?
> 
> I would at least put it back to the default. If someone runs the tests,
> it should at least put it back to what it was at boot. Otherwise,
> someone might run the tests, and then wonder why events are being
> dropped when they are reading the trace.

Umm, we may need to have a knob to reset the ftrace options...
Can we warn such user that if the ftracetest finds that the current
value is not the same what it sets?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
