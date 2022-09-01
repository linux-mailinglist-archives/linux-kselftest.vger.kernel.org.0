Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE93E5A9EDF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 20:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiIASWk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 14:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiIASWj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 14:22:39 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267127C1F6;
        Thu,  1 Sep 2022 11:22:38 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 944CC140976;
        Thu,  1 Sep 2022 18:22:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 088A260018;
        Thu,  1 Sep 2022 18:22:34 +0000 (UTC)
Message-ID: <b028cf83798fd562f5d1b992d2651d53e21acaa2.camel@perches.com>
Subject: Re: [RFC PATCH v1] checkpatch: Handle FILE pointer type
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jerome Forissier <jerome.forissier@linaro.org>
Date:   Thu, 01 Sep 2022 14:22:33 -0400
In-Reply-To: <4f958a0c7c0aa2fce613371348477c002aa58e90.camel@perches.com>
References: <20220901145948.1456353-1-mic@digikod.net>
         <4f958a0c7c0aa2fce613371348477c002aa58e90.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 088A260018
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: aabajss4g3getbegx3b3irk4mhjrigwe
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/ZVDONQtBCY6C8xUN1pjZq3eaTFxSEfyg=
X-HE-Tag: 1662056554-387444
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-09-01 at 11:49 -0400, Joe Perches wrote:
> On Thu, 2022-09-01 at 16:59 +0200, Mickaël Salaün wrote:
> > When using a "FILE *" type, checkpatch considers this an error.  Fix
> > this by explicitly defining "FILE" as a common type.
> []
> > Another error may be throw when we use FIXTURE_{DATA,VARIANT}() structs,
> > as defined in kselftest_harness.h .
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -576,10 +576,17 @@ our $typeKernelTypedefs = qr{(?x:
> >  	(?:__)?(?:u|s|be|le)(?:8|16|32|64)|
> >  	atomic_t
> >  )};
> > +our $typeStdioTypedefs = qr{(?x:
> > +	FILE
> > +)};
> 
> I'm fine with this.
> 
> > +# our $typeKselftestHarnessTypedefs = qr{(?x:
> > +# 	FIXTURE_(?:DATA|VARIANT)\($Ident\)
> > +# )};
> 
> But not this.  Random userspace typedefs should likely
> be kept in some local version of checkpatch.
> 
> Or maybe add a command line option like --additional_typedefs=<file>.

Oops.  I forgot it already exists:

  --typedefsfile             Read additional types from this file

commit 75ad8c575a5ad105e2afc2051c68abceb9c65431
Author: Jerome Forissier <jerome.forissier@linaro.org>
Date:   Mon May 8 15:56:00 2017 -0700

    checkpatch: add --typedefsfile
    
    When using checkpatch on out-of-tree code, it may occur that some
    project-specific types are used, which will cause spurious warnings.
    Add the --typedefsfile option as a way to extend the known types and
    deal with this issue.

