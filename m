Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F97A7515CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 03:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGMB2K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 21:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjGMB2J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 21:28:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF33B7;
        Wed, 12 Jul 2023 18:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C32C7619C2;
        Thu, 13 Jul 2023 01:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B477C433C8;
        Thu, 13 Jul 2023 01:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689211688;
        bh=zdxPwQfi0XD7irleV1pf+Dqh86logNUB0AcfSBb9HC0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=mUmzXUZEmo+Fj67AB64/KR1eorBxpsFJEiFkmfmHHbVgLQCbTPEafWrKeJTRE5y2r
         Pwc9VTJ8CQzf5j7s/FyicP2G2ip/ApbGqJYP/6c13cOr6BK3/u3CYcIbkP0+pkd5Eo
         sLEDUtjm/7MvVtwm9jfKAlYG38y7glvvr4sZNu5n+V57YiNJ70O4Y+So14a4knV27q
         l1yZeRK86744zLtwFurdFjaFksJgZeHZLVur0EGADPCGZ7/Dop2W0UcUJNkfIde5UN
         G6nFt5yBlijoV43ae6759ZcDOjcAwv3QcLs+IqTQMUKwta4ckBVn7kUOyjPCD5SZNZ
         s0BYsaWLn8ROg==
Date:   Wed, 12 Jul 2023 18:28:00 -0700
From:   Kees Cook <kees@kernel.org>
To:     Rae Moar <rmoar@google.com>, shuah@kernel.org, davidgow@google.com,
        dlatypov@google.com, brendan.higgins@linux.dev
CC:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_v2_6/9=5D_kunit=3A_memcpy=3A_Mark?= =?US-ASCII?Q?_tests_as_slow_using_test_attributes?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230707210947.1208717-7-rmoar@google.com>
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-7-rmoar@google.com>
Message-ID: <7C099325-C959-4FC2-82B3-C36BB87D94FC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On July 7, 2023 2:09:44 PM PDT, Rae Moar <rmoar@google=2Ecom> wrote:
>Mark slow memcpy KUnit tests using test attributes=2E
>
>Tests marked as slow are as follows: memcpy_large_test, memmove_test,
>memmove_large_test, and memmove_overlap_test=2E These tests were the slow=
est
>of the memcpy tests and relatively slower to most other KUnit tests=2E Mo=
st
>of these tests are already skipped when CONFIG_MEMCPY_SLOW_KUNIT_TEST is
>not enabled=2E
>
>These tests can now be filtered using the KUnit test attribute filtering
>feature=2E Example: --filter "speed>slow"=2E This will run only the tests=
 that
>have speeds faster than slow=2E The slow attribute will also be outputted=
 in
>KTAP=2E
>
>Note: This patch is intended to replace the use of
>CONFIG_MEMCPY_SLOW_KUNIT_TEST and to potentially deprecate this feature=
=2E
>This patch does not remove the config option but does add a note to the
>config definition commenting on this future shift=2E
>
>Signed-off-by: Rae Moar <rmoar@google=2Ecom>

I remain excited about this series=2E :)

Acked-by: Kees Cook <keescook@chromium=2Eorg>


--=20
Kees Cook
