Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7343D5AACA7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 12:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiIBKj4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 06:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiIBKjz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 06:39:55 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453BB65C5;
        Fri,  2 Sep 2022 03:39:52 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 2B301161137;
        Fri,  2 Sep 2022 10:39:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id A87392000F;
        Fri,  2 Sep 2022 10:39:49 +0000 (UTC)
Message-ID: <026c08d9ab841ef626f80d968a532dea94a37c62.camel@perches.com>
Subject: Re: [RFC PATCH v1] checkpatch: Handle FILE pointer type
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jerome Forissier <jerome.forissier@linaro.org>
Date:   Fri, 02 Sep 2022 03:39:48 -0700
In-Reply-To: <b079d162-fa10-8cf0-bfc9-91f72a440e34@digikod.net>
References: <20220901145948.1456353-1-mic@digikod.net>
         <4f958a0c7c0aa2fce613371348477c002aa58e90.camel@perches.com>
         <b028cf83798fd562f5d1b992d2651d53e21acaa2.camel@perches.com>
         <b079d162-fa10-8cf0-bfc9-91f72a440e34@digikod.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: A87392000F
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 16ymibe4ikt4e3kg6ygzxk33f84tttkb
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19qhTNQ0fbgwDVM/BvlOV2+Wq8OFI4n/iw=
X-HE-Tag: 1662115189-711019
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-09-02 at 11:04 +0200, Mickaël Salaün wrote:
> On 01/09/2022 20:22, Joe Perches wrote:
> > On Thu, 2022-09-01 at 11:49 -0400, Joe Perches wrote:
> > > On Thu, 2022-09-01 at 16:59 +0200, Mickaël Salaün wrote:
> > > > When using a "FILE *" type, checkpatch considers this an error.  Fix
> > > > this by explicitly defining "FILE" as a common type.
> > > []
> > > > Another error may be throw when we use FIXTURE_{DATA,VARIANT}() structs,
> > > > as defined in kselftest_harness.h .
> > > []
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > []
> > > > @@ -576,10 +576,17 @@ our $typeKernelTypedefs = qr{(?x:
> > > >   	(?:__)?(?:u|s|be|le)(?:8|16|32|64)|
> > > >   	atomic_t
> > > >   )};
> > > > +our $typeStdioTypedefs = qr{(?x:
> > > > +	FILE
> > > > +)};
> > > 
> > > I'm fine with this.
> > > 
> > > > +# our $typeKselftestHarnessTypedefs = qr{(?x:
> > > > +# 	FIXTURE_(?:DATA|VARIANT)\($Ident\)
> > > > +# )};
> > > 
> > > But not this.  Random userspace typedefs should likely
> > > be kept in some local version of checkpatch.
> > > 
> > > Or maybe add a command line option like --additional_typedefs=<file>.
> > 
> > Oops.  I forgot it already exists:
> > 
> >    --typedefsfile             Read additional types from this file
> > 
> > commit 75ad8c575a5ad105e2afc2051c68abceb9c65431
> > Author: Jerome Forissier <jerome.forissier@linaro.org>
> > Date:   Mon May 8 15:56:00 2017 -0700
> > 
> >      checkpatch: add --typedefsfile
> >      
> >      When using checkpatch on out-of-tree code, it may occur that some
> >      project-specific types are used, which will cause spurious warnings.
> >      Add the --typedefsfile option as a way to extend the known types and
> >      deal with this issue.
> 
> This doesn't work for the FIXTURE_DATA() case.

checkpatch is a stupid little script.
It's not a c preprocessor nor a syntax complete compiler.
It's really easy for macros to make its output invalid.
If you feed obfuscated c to checkpatch, it'd be confused.
(Same is true for tools like coccinelle btw, though cocci is far better)
checkpatch will never be comprehensive nor perfect.
It's expected its users will use their common sense about its
output message validity.

> And I'm not sure how 
> contributors would know that they need to use this option with a 
> specific file.

--help exists

Maybe Documentation/dev-tools/checkpatch.rst could be expanded for
--verbose mode.

