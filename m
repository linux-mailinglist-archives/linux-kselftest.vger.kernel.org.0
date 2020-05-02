Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2045D1C2315
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 May 2020 06:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgEBEmN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 May 2020 00:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgEBEmN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 May 2020 00:42:13 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3722B20787;
        Sat,  2 May 2020 04:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588394532;
        bh=S1e9cxXKElXzg5pTAonXc9u8JI0iLsAPtXeYi8T50ZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nqpU/4qORKCayZQW2kFw76As9eRL4aqHNo0fRLBkcXbkmkANQf0cmY7U26Rj87YgY
         gpp1DcxXeD6yaKArjwb/oHH67NjTfr0U82atZ5NgakvFGnAlTU2VCF5tZTRM5rSzJW
         1S3TDm7s0YOUzZvnXmEW+K14MtNbn9t/LjsIiRbs=
Date:   Sat, 2 May 2020 13:42:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] ftrace/selftest: make unresolved cases cause
 failure if --fail-unresolved set
Message-Id: <20200502134207.0e60ed383c0867f1d82498fd@kernel.org>
In-Reply-To: <75fc65c3-a639-41cf-0a10-554e632e9612@kernel.org>
References: <1582104810-12983-1-git-send-email-alan.maguire@oracle.com>
        <1582104810-12983-3-git-send-email-alan.maguire@oracle.com>
        <20200219203941.eb0fb66aee13f6d7a47513ac@kernel.org>
        <20200501184208.2529cac8081a34de0b48617f@kernel.org>
        <75fc65c3-a639-41cf-0a10-554e632e9612@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 1 May 2020 08:25:50 -0600
shuah <shuah@kernel.org> wrote:

> On 5/1/20 3:42 AM, Masami Hiramatsu wrote:
> > On Wed, 19 Feb 2020 20:39:41 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> >> On Wed, 19 Feb 2020 09:33:30 +0000
> >> Alan Maguire <alan.maguire@oracle.com> wrote:
> >>
> >>> Currently, ftracetest will return 1 (failure) if any unresolved cases
> >>> are encountered.  The unresolved status results from modules and
> >>> programs not being available, and as such does not indicate any
> >>> issues with ftrace itself.  As such, change the behaviour of
> >>> ftracetest in line with unsupported cases; if unsupported cases
> >>> happen, ftracetest still returns 0 unless --fail-unsupported.  Here
> >>> --fail-unresolved is added and the default is to return 0 if
> >>> unresolved results occur.
> >>>
> >>
> >> OK, this looks good to me. One note, with this change, ftracetest doesn't
> >> fail even if your test environment is not well prepared anymore.
> >>
> >> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Hi Shuah,
> > Could you pick this up?
> > 
> > Po-Hsu Lin seemed to face same problem recently. If this applied, it will be solved.
> > 
> 
> Sorry about this. I will get these in

Thanks Shuah!

> 
> thanks,
> -- Shuah


-- 
Masami Hiramatsu <mhiramat@kernel.org>
