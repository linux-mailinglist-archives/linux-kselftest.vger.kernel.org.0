Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367F2720B06
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 23:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbjFBVgS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 17:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjFBVgR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 17:36:17 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D141B6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 14:36:16 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f6c6320d4eso21681cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685741775; x=1688333775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bXSdg68Nu6Ipeqx4DXmMogRTJ0wZKXtu+V3JAgD7Dw=;
        b=4BEcihJjrkOc1hpBnt/rQMSN2szZBaDAd6GF0MhsvMk+8MnwM9znQsqD6iIwJJmdZn
         SnbSmK5wDS4y+luDI9FyavyR8A2zz9Lv/Q79yoNpBYX1EFCDCVS3j/zC3/o5l3kYwiIS
         ijr5iDY/p7ngfxCwVCFu8AiOK0AFoP9g5/YuyrDB9AqUcG+M9oFbylTw2rJ90VEAXu4/
         PfE+TH6nzUsN8z/00c6+KYIs9Nb7XfcUmIFwhQOrP96I0G7IoUtlT7M/Mdojl5PxCHgR
         bEF/F3e1m7wx5btFqjIxE+dFfqfGPVOZ3xoBRF3IT0R1ax+qIWLnLPLdUOBmCyhHlNsS
         zhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685741775; x=1688333775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bXSdg68Nu6Ipeqx4DXmMogRTJ0wZKXtu+V3JAgD7Dw=;
        b=OQIf4ZJkN31RNnxik+PtZGtYDwDpxlpCdIR85pyU4IvJOnCQJ8WC60Ny+wH/VxjxRr
         pYJN4VkiB+3CKpJvIJJCNMOgL31tEfw3P0szyZAz/9Ql/K+0hhbLeagPA70VicIukTIs
         KHO9kgmAa/8SV6CqvsdLzRvQU2rJK3kEQePzZFGJD/cLW/d2jISuqWhNc+o6X09DyDXk
         aO/WqTPZzDvIYohpDKp9zG8St3LQnsKPqf/LodRbBWPan0wZoa/o2lS8PeW6/eRyqZwG
         EuSrLBk0dRa1yI5hfRDZmFXe0Awg3VMwACXpbO3rBMpFbIn+K8fnUfz1Tg5VCGLJV/0u
         UEvQ==
X-Gm-Message-State: AC+VfDzSw4rTzZLWUTyXr+R5/m2n08V8DnkOhClfukJ5IomuheX/Up3d
        aHNB1R7PKli8unvEbpX8NokG/wTUZjEaveEPNoM0SEn6o4h9LXfcdVYObw==
X-Google-Smtp-Source: ACHHUZ6R/RbK0lgZOsIGD8lNiNYKFwpx2gVJ++04EbFp+o/7g575Bcx1tNgZa4IJRgsldJedUvcqUFCmY0Pk0wzhV2Y=
X-Received: by 2002:a05:622a:11d3:b0:3f8:1f30:a1f2 with SMTP id
 n19-20020a05622a11d300b003f81f30a1f2mr341117qtk.26.1685741775555; Fri, 02 Jun
 2023 14:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230602035400.2333527-1-davidgow@google.com>
In-Reply-To: <20230602035400.2333527-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 2 Jun 2023 14:36:04 -0700
Message-ID: <CAGS_qxqRStkLU9F-+P3TBUO29=CCXLuv=Ca0d-AXpVogYrOTpg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Rename references to kunit_abort()
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 1, 2023 at 8:54=E2=80=AFPM David Gow <davidgow@google.com> wrot=
e:
>
> The kunit_abort() function has been renamed __kunit_abort(), update the
> references to it in the documentation.
>
> Suggested-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks!
Double checked that this was the only remaining reference and that
this patch applied OK.
