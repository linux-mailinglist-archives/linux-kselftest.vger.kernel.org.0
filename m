Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710E65F34A9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Oct 2022 19:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJCRi0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Oct 2022 13:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJCRhg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Oct 2022 13:37:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA5F60E4
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Oct 2022 10:37:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m3so15580796eda.12
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Oct 2022 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ijFN0pckMxMj1+3wCxL1Fk38QuW7ODIv6czvGYPmiDw=;
        b=sJqIrooGQ/qLu5yTUeUgcIsVc14jPuOsV0OKUcmVRacbYyxIBu2XF8HLpNbDQXuU68
         FWVaL0oHcJoGJg03MfD3V4SoIheIQ2N1+w7q5x9InZPsAmiO+cNrcUW6u6kEaxVZiceH
         dAdLV5XdjfoT5GREPCzQx01GKCfxNQiSxu20KGkFjXrQVt9NfNa/7gvYgFkssVmhRakw
         VbNsl8q8ffbRdcQUrfXVClm1hRbXXxss5Ohczg9Cvo5NQiAFIvOAlc9uXhVikTHtUvLQ
         bGrFCumdEK0nksxZGCK86od7+9FxISNFTlaI/ZN8sVOASRMExMY8LTswk3dCJGufAGiR
         x+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ijFN0pckMxMj1+3wCxL1Fk38QuW7ODIv6czvGYPmiDw=;
        b=zvYeULOiYi4tafLA0FW7Q9O/VFAw4+AJ5k4uEDUP+0gElMfojfO8gtJtlH9LczZ0X4
         7HpWIssMNxDxkqu5MRIP2QoZXR8RjQCOFwbxcMQO7q162ZPNEj83EuOmPDw0av7MCeqa
         i6syFZopJsx/nLWhNu9dWME0hFELvCZEpf8Xf221ZwxQZmHlmg0t9Mtfvlie1pgzVrHE
         xk9l6UOmJ7ezjIQtNb3zJQqB1cDs3YCRqwKYyGTpbxiLDUorCj1A8romA1Wy8I9uhexX
         BTxCxvV31OeqmX0PtjnsfJb3AsV4g3ETK9E5zIf2N0QmZEPBti3GzcOjcusyZpU5O8fi
         oe+w==
X-Gm-Message-State: ACrzQf2Xw5FnqcX3OkYBYCm4cWMgdwNfodH1UwC2r3yiucOI5KYStYYX
        C53c6ttwpNOUEKNDVWSgel1+9Ipe31xeXwl7psPWFw==
X-Google-Smtp-Source: AMsMyM7uV2LC47ucZYAkhghPD5jv0D7R8fSPqJuy+W0I0ktRQ8MOwqssCZgV4a9AI56+Ihtn47Mqf7auGrP2BYPGS/k=
X-Received: by 2002:a05:6402:1c19:b0:458:c83b:6253 with SMTP id
 ck25-20020a0564021c1900b00458c83b6253mr8999295edb.313.1664818653798; Mon, 03
 Oct 2022 10:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221001064643.667075-1-davidgow@google.com>
In-Reply-To: <20221001064643.667075-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 3 Oct 2022 10:37:22 -0700
Message-ID: <CAGS_qxrpjrSA7VF=dOavkq34tjH72P2dZ84BG2No5U7rNXBHCQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Update description of --alltests option
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Jonathan Corbet <corbet@lwn.net>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 30, 2022 at 11:46 PM David Gow <davidgow@google.com> wrote:
>
> kunit_tool's --alltests option was changed in commit
> 980ac3ad0512 ("kunit: tool: rename all_test_uml.config, use it for --alltests")
> to use a manually curated list of architecture-indpendent Kconfig
> options, rather than attempting to use make allyesconfig on UML, which
> was broken.
>
> Update the kunit_tool documentation to reflect the new behaviour of
> --alltests.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks!
