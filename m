Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2826DE194
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDKQyk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjDKQyd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:54:33 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30441FC1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 09:54:20 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id k20so6147695ual.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681232060;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F71unJe9XkkD1yiEd91tBItKPtT8TRWutHxtJYNo1dI=;
        b=UwmklR3MdX0WhiQkRLbx59WR0X3pYtmmT7qUXTeW5lv3wMXsmMSFccSk1WyGudSi/Y
         GNKH/8w6Xpk0Luua5z8cOheRi65gGFSy5B3KWJ+/IvZUw1fKmvpH3edD1CIWtpCq9TMk
         Ry94fFwATs6RfBOoOjb2bmtFmD2BDvgori7z34j+st+X05btn15gmF86iPYfo/OAxs79
         QanE7p8rOOOMc7EyDl+vYTMWO2edXc/CdePk9qFpjeNE6tYYCfvBAgrbBmTAqJBhmfrE
         mSH/8PNVevvNZ0/FKX0NWfQ6gHkOjKjKD5HjKYACk8He51r1pVC3vZ+rImV1DioNPwAY
         T3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232060;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F71unJe9XkkD1yiEd91tBItKPtT8TRWutHxtJYNo1dI=;
        b=eeNI5deFjhnFHwxw/gf+uEkIyKFpIQATaSBXO6ln8LvqhdO0DTtmFLATvnG3CnpEIn
         SaBGEXTkeD573xW288U5VAVgjJwFu/J/rDP2CIjbhUv+KyrP7vAJeEWqBeuxShAe6Yj+
         c/y+P3PXlq0vx9kCmaQR9rcEbXgQf3vOFMUpZBY4tv9BXsd11O+eVnYJlMiqZtJlDIhq
         5wLrY6IBl9cBKtdyamNWvWXCsRTV5hSAiKf8DlQNSOVmta2lkJ4f21RI55lAjVb9sW2X
         NkElI+3K9N5AuKHSDPIkEQJTuLL8FprmU0MxgPOSEmSmInuZIdML3TcF+eKteeZgCl9k
         7ttQ==
X-Gm-Message-State: AAQBX9dJDzqzVc3t/ySfGrNwzRzNLG1ycABsEzm0lwrBzc7eGj6umwO6
        C4FFrsX0rflRmMzx4p0QG3dOcNFjQRj5JEv1la16DA==
X-Google-Smtp-Source: AKy350bOBalEYKjHMGBzfpvbyvEVbEUfEUk6ROvFzB8lX7mUFMXtVcBTscRn6ADpAbQfvZPiIlKlNpjw9a413fLL9dw=
X-Received: by 2002:a1f:3041:0:b0:43f:c4ba:48ec with SMTP id
 w62-20020a1f3041000000b0043fc4ba48ecmr5650102vkw.0.1681232059655; Tue, 11 Apr
 2023 09:54:19 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 11 Apr 2023 22:24:08 +0530
Message-ID: <CA+G9fYt1vAeJY52uK13BQtLJyE9LJvFz6e6VCHt9Pxp7zNpa4Q@mail.gmail.com>
Subject: selftests: # Warning: file test_ingress_egress_chaining.sh is not executable
To:     Netdev <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Blakey <paulb@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest net test_ingress_egress_chaining.sh seems to be missing file
execute permissions.

Do you notice at your end ?

# selftests: net: test_ingress_egress_chaining.sh
# Warning: file test_ingress_egress_chaining.sh is not executable


https://lkft.validation.linaro.org/scheduler/job/6339612#L8152
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc6-16-g0d3eb744aed4/testrun/16161555/suite/kselftest-net/test/net_test_ingress_egress_chaining_sh/history/
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc6-16-g0d3eb744aed4/testrun/16161555/suite/kselftest-net/test/net_test_ingress_egress_chaining_sh/details/


--
Linaro LKFT
https://lkft.linaro.org
