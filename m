Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0016C8B145
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfHMHhX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 03:37:23 -0400
Received: from gofer.mess.org ([88.97.38.141]:36101 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfHMHhX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 03:37:23 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 4364F603E8; Tue, 13 Aug 2019 08:37:22 +0100 (BST)
Date:   Tue, 13 Aug 2019 08:37:22 +0100
From:   Sean Young <sean@mess.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-media@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 3/3] selftests: ir: fix ir_loopback test failure
Message-ID: <20190813073722.lsdto67orvlgacra@gofer.mess.org>
References: <20190810114458.8883-1-sean@mess.org>
 <20190810114458.8883-3-sean@mess.org>
 <7b612199-542e-a4e6-6544-3cd4936f72e4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b612199-542e-a4e6-6544-3cd4936f72e4@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 12, 2019 at 08:25:41AM -0600, shuah wrote:
> On 8/10/19 5:44 AM, Sean Young wrote:
> > The decoder is called rc-mm, not rcmm. This was renamed late in the cycle
> > so this bug crept in.
> > 
> > Cc: Shuah Khan <shuah@kernel.org>
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >   tools/testing/selftests/ir/ir_loopback.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
> > index e700e09e3682..af7f9c7d59bc 100644
> > --- a/tools/testing/selftests/ir/ir_loopback.c
> > +++ b/tools/testing/selftests/ir/ir_loopback.c
> > @@ -54,9 +54,9 @@ static const struct {
> >   	{ RC_PROTO_RC6_MCE, "rc-6-mce", 0x00007fff, "rc-6" },
> >   	{ RC_PROTO_SHARP, "sharp", 0x1fff, "sharp" },
> >   	{ RC_PROTO_IMON, "imon", 0x7fffffff, "imon" },
> > -	{ RC_PROTO_RCMM12, "rcmm-12", 0x00000fff, "rcmm" },
> > -	{ RC_PROTO_RCMM24, "rcmm-24", 0x00ffffff, "rcmm" },
> > -	{ RC_PROTO_RCMM32, "rcmm-32", 0xffffffff, "rcmm" },
> > +	{ RC_PROTO_RCMM12, "rcmm-12", 0x00000fff, "rc-mm" },
> > +	{ RC_PROTO_RCMM24, "rcmm-24", 0x00ffffff, "rc-mm" },
> > +	{ RC_PROTO_RCMM32, "rcmm-32", 0xffffffff, "rc-mm" },
> >   };
> >   int lirc_open(const char *rc)
> > 
> 
> Thanks Sean! Please cc - linux-keseltest makling list on these patches.

I'll do that next time, thanks.

> I can take this through my tree or here is my Ack for it go through
> media tree
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

I'm just preparing a pull request for Mauro so I'll put it in there
with your Ack.

Thank you

Sean
