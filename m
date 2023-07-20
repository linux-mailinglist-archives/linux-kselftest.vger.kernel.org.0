Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0017575A54E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 07:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjGTFDi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 01:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGTFDg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 01:03:36 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BF4BE;
        Wed, 19 Jul 2023 22:03:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0608D6015E;
        Thu, 20 Jul 2023 07:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689829411; bh=ATlhYaC4/eBWEtfxH5B5MahIAXkAd2Dl3aEC80RgbtA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=0GFQfHp57rZE3O7//QvLdaIk3wecUDr+qys/SFnxJEoSBDadfF5VViDHUz0lag8xY
         XUSPOwfemzh9wE3Enof5apqg7JwnMXW3iU7AQD5x6xBCGT377NDH51AJo8ep4GxPy4
         yozekWGSORY9TOg2XocUfn/UPpkUUjS/KQd0TDS+9NDDWOyYu37ABwlTkApPKPMxXN
         Lv5GYDMoiYNklx7OsRLyyGv4zi6rzLI4nvWpPdd6BL+tDEIeCD+riiSUBMccYZxw7t
         0xiJH+JYEXYAqEEQ+m4whYPzXZzOTgrEEw8PItoKMjkLakbZ9biwgawSQt6gtf2W9C
         u7jHHqbqqc8IA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 33o0xE-ZJ_c7; Thu, 20 Jul 2023 07:03:28 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id A160360157;
        Thu, 20 Jul 2023 07:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689829408; bh=ATlhYaC4/eBWEtfxH5B5MahIAXkAd2Dl3aEC80RgbtA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X0VMgcGh+QgHSRj5tZAf5IWszAcX4u9C+ioajSpcDckDpdpsXUP76GHkZeLKiN8gk
         8Pv3xkEVRXZDSjRdTZxrFXLgGOc1YRVHWIeDZfS8CbmkQbI5UYJhKbS+rXNK0XEoTh
         PTrIqJIgA8IHTOtuwk/5grJ6CnO6obddRqPpHM08tAYXByHT0ejQCaAYad0cXEKkUI
         aRKzDWQHolYLEuU5TvXT7nsQ0+Y9Ppmf2G13FtBRiljO2G3hAdtghRZIH3mNVtZTyx
         9jjk9rw+Nvq3td4TcZpkgp1UGrTj0q4eU+I+2FG5uydSfsHmUdQoC4wEbaEDBRjFRI
         jIS+poqpj7uDw==
Message-ID: <7bd3ef7b-a4dc-6d0f-6d58-66533de292cf@alu.unizg.hr>
Date:   Thu, 20 Jul 2023 07:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PROBLEM] selftests: net/forwarding/bridge_mdb.sh: 'Command
 "replace" is unknown, try "bridge mdb help"'
To:     Ido Schimmel <idosch@idosch.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org
References: <6b04b2ba-2372-6f6b-3ac8-b7cba1cfae83@alu.unizg.hr>
 <ZLffjNMaJZiGJytj@shredder>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZLffjNMaJZiGJytj@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/19/23 15:05, Ido Schimmel wrote:
> On Tue, Jul 18, 2023 at 09:02:31PM +0200, Mirsad Todorovac wrote:
>> Command "replace" is unknown, try "bridge mdb help".
> 
> You are running the test with an old iproute2 that doesn't support the
> replace command. The following patches [1][2] skip the tests in this
> case. However, you will get better test coverage with iproute2-next [3]
> compared to the version shipped with your distribution.

You are right and though I was using the latest iproute2 from the
Ubuntu 22.04 LTS and 22.10, the iproute2-next had unlocked the test suite.

> [1]
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> index ae3f9462a2b6..a1bd4900acb6 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> @@ -1206,6 +1206,12 @@ ctrl_test()
>          ctrl_mldv2_is_in_test
>   }
>   
> +bridge mdb help 2>&1 | grep -q "replace"
> +if [ $? -ne 0 ]; then
> +       echo "SKIP: iproute2 too old, missing bridge mdb replace support"
> +       exit $ksft_skip
> +fi
> +
>   trap cleanup EXIT
>   
>   setup_prepare
> 
> [2]
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
> index ae255b662ba3..a1c4aec4cbb1 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
> @@ -1328,6 +1328,12 @@ test_8021qvs()
>          switch_destroy
>   }
>   
> +bridge link help 2>&1 | grep -q "mcast_max_groups"
> +if [ $? -ne 0 ]; then
> +       echo "SKIP: iproute2 too old, missing bridge \"mcast_max_groups\" support"
> +       exit $ksft_skip
> +fi
> +
>   trap cleanup EXIT
>   
>   setup_prepare
> 
> [3] https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git
