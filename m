Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC6F6CBC9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 12:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjC1KgH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 06:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjC1KgA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 06:36:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763961A9
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=ue8lVFTw41+HjVbSxcYnFtFPbn0vozjoD/AfW41NI5Q=; t=1679999752; x=1681209352; 
        b=OgAxU89aozvu4s9niP9Twqvx4yGe75jUPmCbC82qn7SPq13N+NwV4ksXdvtm61fB+OOGyQEy45Z
        6rran5ksifglzlQ3Eb9dJSiRJTIl0OMEM7bzKEOyAgUAWa7H3swlDWzrZizu6fjAtmO3ADQbTxeTv
        OcUIBtEtBTCVvuXoTA22apOtvSFQ1vr3+aqxEvdEfb/P2HTjrsdWEX7TNVexYOHUY6sLhUGsjNecg
        Hp5A1ijKwTJVMwYqfLD2tNhP6Itho4P5x8oPPlL5x6atOO/w1U0Dqjl6JLOalrIqAiNA6GZpDbNfk
        ttCI4rAbxOuIB+0dlNBF8CcPFiJWHq6oozqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ph6g9-00Gg6e-2B;
        Tue, 28 Mar 2023 12:35:49 +0200
Message-ID: <0bfe4ca4863c22208d09d9b437cc563ed50877a1.camel@sipsolutions.net>
Subject: new kunit infrastructure
From:   Johannes Berg <johannes@sipsolutions.net>
To:     KUnit Development <kunit-dev@googlegroups.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org,
        Benjamin Berg <benjamin@sipsolutions.net>
Date:   Tue, 28 Mar 2023 12:35:48 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

Is there an established process for new kunit infrastructure?

For example, we have this macro that makes KUNIT_ARRAY_PARAM easier by
letting you just declare an array of test cases:

/* Similar to KUNIT_ARRAY_PARAM, but avoiding an extra function */
#define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)					\
	static const void *name##_gen_params(const void *prev, char *desc)			\
	{											\
		typeof((array)[0]) *__next =3D prev ? ((typeof(__next)) prev) + 1 : (arra=
y);	\
		if (__next - (array) < ARRAY_SIZE((array))) {					\
			strscpy(desc, __next->desc_member, KUNIT_PARAM_DESC_SIZE);		\
			return __next;								\
		}										\
		return NULL;									\
	}


Also, since we're working on wifi and thus networking, we want e.g. SKBs
to be resource-managed, and added some helper macros/functions for using
kunit_alloc_resource() with SKBs, that will be used at least in cfg80211
and mac80211 soon, so it would seem appropriate to have
include/kunit/skb.h (and a corresponding C file somewhere) with these
helpers.


Is all of this just a case of "nobody needed it so far", or is there no
expectation to add such infrastructure more generally?

johannes
