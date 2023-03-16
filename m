Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23076BC77E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 08:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCPHmX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 03:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPHmW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 03:42:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F148C0D7
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TdhTATLYZCPgciCYprZEWjfRBCTlzy5l6H31KfXsMxE=;
        t=1678952538; x=1680162138; b=cZu2vIC9aQ07DFPpyfQLnw2NaEGcIlHaZSL6bIGBgFAI/Kp
        RC0YzzqL3Sdr9VuTHswZ6/kLaEUG5mxIFqIAwniz+ZI5HHV9Vm6BTbzaD0tQqR7sO8hBE6Sgbywah
        Z545COeckBIeJsRDEAGhe9LUWcZjUuhUaRjFp/8rbXYAkl4F0LHfnAj+Y7oWZOJ6CXyaM/1tGpu6Z
        onunwCEvT9nNa08SfDnyiQx3vU6YWkzbh79u/6Jx2MP6LF4KkKo8poTAE/RJEyvxAbUyM3JYvc2XN
        60owvk0bJPtow9ahRgqS9UIqBjz/Ll+cQ7vXv9Z2IECbM8NAfhiGVxXyaTAZXaag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pciFa-00530Y-0c;
        Thu, 16 Mar 2023 08:42:14 +0100
Message-ID: <e028d27b3e998eaba2d71b6e224eb707015f8edf.camel@sipsolutions.net>
Subject: Re: [PATCH] kunit: tool: fix type annotation for IO
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Date:   Thu, 16 Mar 2023 08:42:12 +0100
In-Reply-To: <CAGS_qxrJ53EyQaf5WqfSBYhOF0+LvWgvKL4gExu9vCPxRb7ipw@mail.gmail.com>
References: <20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid>
         <CAGS_qxrJ53EyQaf5WqfSBYhOF0+LvWgvKL4gExu9vCPxRb7ipw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-03-15 at 23:02 -0700, Daniel Latypov wrote:
> On Wed, Mar 15, 2023 at 10:57=E2=80=AFPM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> >=20
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > This should be IO[str], since we use it for printing strings.
>=20
> This is a good catch, thanks.
> But we also have a few more bare generic types that warrant attention.

Oh, that might well be true. I was using kunit_parser in a script, and
that imports kunit_printer, and then tried to check *my* script for type
annotations with mypy. This led it to go check through the dependencies
too, and since it was just one small thing there I decided to just fix
it rather than figure out how to tell mypy that I don't care about those
dependencies :-)

Now for everything else? I didn't even look.

> I think the diff below [1] should fix the others as well.
> I can send it out as a formal patch and add your name for the Reported-by=
?

Sure!

johannes


