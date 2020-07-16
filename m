Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471DF222852
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 18:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgGPQej (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 12:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbgGPQei (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 12:34:38 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA6C08C5C0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:34:38 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id a32so5359303qtb.5
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lwyaXUfqacdPlpyLu1Ttlgin1z8vmVU0cbnn1bX1Rnk=;
        b=kA8Qup/sWomuaFxIOO6vCCpH5mdq609XlQjKi+LNUueO9HuwKKxGC6ycKuLw6fyBol
         wLx/xqa9aMw+Tb7zPDMr5CkoFvIeqIHuHXotI12d5aP5Jv3a2vGPhs4TdlHks0ze8BIk
         D73euv0PW5AdyXr6+vuojhzPupja4OdU04meNo4eYNulJUulyDt30xoZmgJQKP3fuwdl
         ckeUGwqX5J5Doo1wqfcBh0X6fmTPFPXya51SkViydOnIMXKc0c4Ulr4KRra+sxipelnl
         wOfwChHf31VjNweNSbiBoC1DpA+NEN0weXQTB7lbjc4bg9Rv917i1rn7btn4LLBy5rpG
         16RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lwyaXUfqacdPlpyLu1Ttlgin1z8vmVU0cbnn1bX1Rnk=;
        b=l2RaWDSGaIuyfEL21tOqtAdBNXwxK4WMYJ209mSwcOtm+YWQkgNxmEgPa26nktrSJv
         pxNOKddK4ccplgATcVEAxbivXt1/vgIMKgpWMZXRgWRUSxf953JPNr+84BSjm3eNgJxF
         8bmSiacUL6HkU7anHQfO5J8H8Rs0+MO1G7iJlJL/EL11XSxff69efu5YPUMug+ayY/8Z
         EngzytWa5KfFY49frKjEbcGYmCMEXsJ7MK0jx+FEfPyKAqeh8UHWL/8hs/Xw6BGtBN5v
         vuvyHvR7x6chjQOYWOX8EpCZVL/3/6CcKhWns+JFRV8JvzO2PfJC1Kse80mAjsn87fVE
         I0rQ==
X-Gm-Message-State: AOAM533gYH+KFdqKH5oGNUivWmJdMDAX8y9yB3ciS1VB/vbdN8XzqG2R
        ao/pHzeBoMh2YUTvrzxYAR0dHg==
X-Google-Smtp-Source: ABdhPJxGLZF555OxEgKFP56c+hng7TNo5R9fG9j2yBMIKe8pI7zjOTXywADBomVaByLYnnx74FbIxQ==
X-Received: by 2002:ac8:c7:: with SMTP id d7mr6014106qtg.235.1594917277209;
        Thu, 16 Jul 2020 09:34:37 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id l202sm7554664qke.109.2020.07.16.09.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 09:34:34 -0700 (PDT)
Message-ID: <e73d3e69ca55f5281f23802fb76e2e0a406305ed.camel@massaru.org>
Subject: Re: [RFC 1/3] kunit: tool: Add support root filesystem in kunit-tool
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 16 Jul 2020 13:34:31 -0300
In-Reply-To: <CAFd5g47v87+aNyxUfsJna0qQUF5sr_2COcz5JXkfxe9s8kha5w@mail.gmail.com>
References: <20200715031120.1002016-1-vitor@massaru.org>
         <20200715031120.1002016-2-vitor@massaru.org>
         <CAFd5g47v87+aNyxUfsJna0qQUF5sr_2COcz5JXkfxe9s8kha5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-07-15 at 17:29 -0700, 'Brendan Higgins' via KUnit
Development wrote:
> On Tue, Jul 14, 2020 at 8:11 PM Vitor Massaru Iha <vitor@massaru.org>
> wrote:
> > This makes it possible to use KUnit tests as modules.
> > And with that the tests can run in userspace.
> > 
> > The filesystem was created using debootstrap:
> >    sudo debootstrap buster buster_rootfs
> > 
> > And change the owner of the root filesystem files
> > for your user:
> >    sudo chown -R $USER:$USER buster_rootfs
> 
> Probably want to add this to the documentation for KUnit.
> 
> > For the kunit-tool to correctly capture the test results,
> > uml_utilities must be installed on the host to halt uml.
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> 
> Overall this looks really good! I am really excited to see this!
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> > ---
> >  tools/testing/kunit/kunit.py        |  37 ++++++++--
> >  tools/testing/kunit/kunit_kernel.py | 105
> > ++++++++++++++++++++++++----
> >  2 files changed, 121 insertions(+), 21 deletions(-)
> > 
> > diff --git a/tools/testing/kunit/kunit.py
> > b/tools/testing/kunit/kunit.py
> > index 787b6d4ad716..6d8ba0215b90 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -23,16 +23,16 @@ import kunit_parser
> >  KunitResult = namedtuple('KunitResult',
> > ['status','result','elapsed_time'])
> > 
> >  KunitConfigRequest = namedtuple('KunitConfigRequest',
> > -                               ['build_dir', 'make_options'])
> > +                               ['build_dir', 'uml_root_dir',
> > 'make_options'])
> >  KunitBuildRequest = namedtuple('KunitBuildRequest',
> > -                              ['jobs', 'build_dir', 'alltests',
> > +                              ['jobs', 'build_dir',
> > 'uml_root_dir', 'alltests',
> >                                 'make_options'])
> >  KunitExecRequest = namedtuple('KunitExecRequest',
> > -                             ['timeout', 'build_dir', 'alltests'])
> > +                             ['timeout', 'build_dir',
> > 'uml_root_dir', 'alltests'])
> >  KunitParseRequest = namedtuple('KunitParseRequest',
> >                                ['raw_output', 'input_data'])
> >  KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout',
> > 'jobs',
> > -                                          'build_dir', 'alltests',
> > +                                          'build_dir',
> > 'uml_root_dir', 'alltests',
> >                                            'make_options'])
> > 
> >  KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
> > @@ -47,7 +47,6 @@ def create_default_kunitconfig():
> >         if not os.path.exists(kunit_kernel.kunitconfig_path):
> >                 shutil.copyfile('arch/um/configs/kunit_defconfig',
> >                                 kunit_kernel.kunitconfig_path)
> > -
> >  def get_kernel_root_path():
> >         parts = sys.argv[0] if not __file__ else __file__
> >         parts =
> > os.path.realpath(parts).split('tools/testing/kunit')
> > @@ -58,10 +57,22 @@ def get_kernel_root_path():
> >  def config_tests(linux: kunit_kernel.LinuxSourceTree,
> >                  request: KunitConfigRequest) -> KunitResult:
> >         kunit_parser.print_with_timestamp('Configuring KUnit Kernel
> > ...')
> > +       defconfig = False
> > 
> >         config_start = time.time()
> >         create_default_kunitconfig()
> > -       success = linux.build_reconfig(request.build_dir,
> > request.make_options)
> > +
> > +       if request.uml_root_dir != None:
> > +               if os.path.exists(request.uml_root_dir):
> > +                       kunit_kernel.uml_root_path =
> > os.path.abspath(request.uml_root_dir)
> > +                       defconfig = True
> > +               else:
> > +                       config_end = time.time()
> > +                       return
> > KunitResult(KunitStatus.CONFIG_FAILURE,
> > +                                       'could not configure
> > kernel',
> > +                                       config_end - config_start)
> > +
> > +       success = linux.build_reconfig(request.build_dir,
> > defconfig, request.make_options)
> >         config_end = time.time()
> >         if not success:
> >                 return KunitResult(KunitStatus.CONFIG_FAILURE,
> > @@ -79,6 +90,7 @@ def build_tests(linux:
> > kunit_kernel.LinuxSourceTree,
> >         success = linux.build_um_kernel(request.alltests,
> >                                         request.jobs,
> >                                         request.build_dir,
> > +                                       request.uml_root_dir,
> >                                         request.make_options)
> >         build_end = time.time()
> >         if not success:
> > @@ -97,7 +109,7 @@ def exec_tests(linux:
> > kunit_kernel.LinuxSourceTree,
> >         test_start = time.time()
> >         result = linux.run_kernel(
> >                 timeout=None if request.alltests else
> > request.timeout,
> > -               build_dir=request.build_dir)
> > +               build_dir=request.build_dir,
> > uml_root_dir=request.uml_root_dir)
> > 
> >         test_end = time.time()
> > 
> > @@ -130,12 +142,14 @@ def run_tests(linux:
> > kunit_kernel.LinuxSourceTree,
> >         run_start = time.time()
> > 
> >         config_request = KunitConfigRequest(request.build_dir,
> > +                                           request.uml_root_dir,
> >                                             request.make_options)
> >         config_result = config_tests(linux, config_request)
> >         if config_result.status != KunitStatus.SUCCESS:
> >                 return config_result
> > 
> >         build_request = KunitBuildRequest(request.jobs,
> > request.build_dir,
> > +                                         request.uml_root_dir,
> >                                           request.alltests,
> >                                           request.make_options)
> >         build_result = build_tests(linux, build_request)
> > @@ -143,6 +157,7 @@ def run_tests(linux:
> > kunit_kernel.LinuxSourceTree,
> >                 return build_result
> > 
> >         exec_request = KunitExecRequest(request.timeout,
> > request.build_dir,
> > +                                       request.uml_root_dir,
> >                                         request.alltests)
> >         exec_result = exec_tests(linux, exec_request)
> >         if exec_result.status != KunitStatus.SUCCESS:
> > @@ -168,6 +183,10 @@ def add_common_opts(parser):
> >                             help='As in the make command, it
> > specifies the build '
> >                             'directory.',
> >                              type=str, default='.kunit',
> > metavar='build_dir')
> > +       parser.add_argument('--uml_root_dir',
> > +                           help='To load modules, a root
> > filesystem is '
> > +                           'required to install and load these
> > modules.',
> > +                            type=str, default=None,
> > metavar='uml_root_dir')
> >         parser.add_argument('--make_options',
> >                             help='X=Y make option, can be
> > repeated.',
> >                             action='append')
> > @@ -252,6 +271,7 @@ def main(argv, linux=None):
> >                                        cli_args.timeout,
> >                                        cli_args.jobs,
> >                                        cli_args.build_dir,
> > +                                      cli_args.uml_root_dir,
> >                                        cli_args.alltests,
> >                                        cli_args.make_options)
> >                 result = run_tests(linux, request)
> > @@ -272,6 +292,7 @@ def main(argv, linux=None):
> >                         linux = kunit_kernel.LinuxSourceTree()
> > 
> >                 request = KunitConfigRequest(cli_args.build_dir,
> > +                                            cli_args.uml_root_dir,
> >                                              cli_args.make_options)
> >                 result = config_tests(linux, request)
> >                 kunit_parser.print_with_timestamp((
> > @@ -295,6 +316,7 @@ def main(argv, linux=None):
> > 
> >                 request = KunitBuildRequest(cli_args.jobs,
> >                                             cli_args.build_dir,
> > +                                           cli_args.uml_root_dir,
> >                                             cli_args.alltests,
> >                                             cli_args.make_options)
> >                 result = build_tests(linux, request)
> > @@ -319,6 +341,7 @@ def main(argv, linux=None):
> > 
> >                 exec_request = KunitExecRequest(cli_args.timeout,
> >                                                 cli_args.build_dir,
> > +                                               cli_args.uml_root_d
> > ir,
> >                                                 cli_args.alltests)
> >                 exec_result = exec_tests(linux, exec_request)
> >                 parse_request =
> > KunitParseRequest(cli_args.raw_output,
> > diff --git a/tools/testing/kunit/kunit_kernel.py
> > b/tools/testing/kunit/kunit_kernel.py
> > index 63dbda2d029f..d712f4619eaa 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -11,6 +11,7 @@ import logging
> >  import subprocess
> >  import os
> >  import signal
> > +import time
> > 
> >  from contextlib import ExitStack
> > 
> > @@ -19,7 +20,59 @@ import kunit_parser
> > 
> >  KCONFIG_PATH = '.config'
> >  kunitconfig_path = '.kunitconfig'
> > +X86_64_DEFCONFIG_PATH = 'arch/um/configs/x86_64_defconfig'
> >  BROKEN_ALLCONFIG_PATH =
> > 'tools/testing/kunit/configs/broken_on_uml.config'
> > +uml_root_path = None
> 
> nit: I don't like global variables. Can we just pass this in or store
> it in a data structure. The above are all constants.
> 
> > +
> > +make_cmd = {
> 
> This looks like a constant. Please capitalize it.
> 
> > +       'make': {
> > +               'command': ['make', 'ARCH=um'],
> > +               'msg_error': 'Could not call execute make: ',
> > +       },
> > +       'make_modules': {
> > +               'command': ['make', 'modules', 'ARCH=um'],
> > +               'msg_error': 'Could not call execute make modules:
> > ',
> > +       },
> > +       'make_modules_install': {
> > +               'command': ['make', 'modules_install', 'ARCH=um'],
> > +               'msg_error': 'Could not call execute make
> > modules_install: ',
> > +       }
> > +}
> > 
> > +def halt_uml():
> > +       try:
> > +               subprocess.call(['uml_mconsole', 'kunitid',
> > 'halt'])
> > +       except OSError as e:
> > +               raise ConfigError('Could not call uml_mconsole ' +
> > e)
> > +       except subprocess.CalledProcessError as e:
> > +                       raise ConfigError(e.output)
> > +
> > +
> > +def enable_uml_modules_on_boot(output_command):
> > +       uml_modules_path = None
> > +       found_kernel_version = False
> > +       modules = []
> > +       for i in output_command.decode('utf-8').split():
> > +               if found_kernel_version:
> > +                       kernel_version = i
> > +                       uml_modules_path =
> > os.path.join(uml_root_path,
> > +                             'lib/modules/', kernel_version,
> > 'kernel/lib/')
> > +                       break
> > +               if 'DEPMOD' in i:
> > +                       found_kernel_version = True
> > +
> > +       try:
> > +               if os.path.exists(uml_modules_path):
> > +                       modules = subprocess.check_output(['ls',
> > +                                           uml_modules_path]).deco
> > de('utf-8').split()
> > +       except OSError as e:
> > +               raise ConfigError('Could not list directory ' + e)
> > +       except subprocess.CalledProcessError as e:
> > +                       raise ConfigError(e.output)
> > +
> > +       with open(os.path.join(uml_root_path, 'etc/modules'), 'w')
> > as f:
> > +               for i in modules:
> > +                       f.write(i.replace('.ko', ''))
> > 
> >  class ConfigError(Exception):
> >         """Represents an error trying to configure the Linux
> > kernel."""
> > @@ -70,20 +123,27 @@ class LinuxSourceTreeOperations(object):
> >                 kunit_parser.print_with_timestamp(
> >                         'Starting Kernel with all configs takes a
> > few minutes...')
> > 
> > -       def make(self, jobs, build_dir, make_options):
> > -               command = ['make', 'ARCH=um', '--jobs=' +
> > str(jobs)]
> > +       def make(self, cmd, jobs, build_dir, make_options):
> > +               command = make_cmd[cmd]['command'] + ['--jobs=' +
> > str(jobs)]
> > +
> >                 if make_options:
> >                         command.extend(make_options)
> >                 if build_dir:
> >                         command += ['O=' + build_dir]
> > +
> > +               if cmd == 'make_modules_install':
> > +                       command += ['INSTALL_MOD_PATH=' +
> > uml_root_path]
> > +
> >                 try:
> > -                       subprocess.check_output(command)
> > +                       output = subprocess.check_output(command)
> > +                       if cmd == 'make_modules_install':
> > +                                enable_uml_modules_on_boot(output)
> >                 except OSError as e:
> > -                       raise BuildError('Could not call execute
> > make: ' + e)
> > +                       raise BuildError(make_cmd[cmd][msg_error] +
> > e)
> >                 except subprocess.CalledProcessError as e:
> >                         raise BuildError(e.output)
> > 
> > -       def linux_bin(self, params, timeout, build_dir, outfile):
> > +       def linux_bin(self, params, timeout, build_dir,
> > uml_root_dir, outfile):
> >                 """Runs the Linux UML binary. Must be named
> > 'linux'."""
> >                 linux_bin = './linux'
> >                 if build_dir:
> > @@ -92,7 +152,11 @@ class LinuxSourceTreeOperations(object):
> >                         process = subprocess.Popen([linux_bin] +
> > params,
> >                                                    stdout=output,
> >                                                    stderr=subproces
> > s.STDOUT)
> > -                       process.wait(timeout)
> > +                       if uml_root_dir:
> > +                               time.sleep(timeout)
> > +                               halt_uml()
> > +                       else:
> > +                               process.wait(timeout)
> > 
> > 
> >  def get_kconfig_path(build_dir):
> > @@ -132,11 +196,16 @@ class LinuxSourceTree(object):
> >                         return False
> >                 return True
> > 
> > -       def build_config(self, build_dir, make_options):
> > +       def build_config(self, build_dir, defconfig, make_options):
> >                 kconfig_path = get_kconfig_path(build_dir)
> >                 if build_dir and not os.path.exists(build_dir):
> >                         os.mkdir(build_dir)
> >                 self._kconfig.write_to_file(kconfig_path)
> > +
> > +               if defconfig:
> > +                       with open(kconfig_path, 'a')  as fw:
> > +                               with open(X86_64_DEFCONFIG_PATH,
> > 'r') as fr:
> > +                                       fw.write(fr.read())
> >                 try:
> >                         self._ops.make_olddefconfig(build_dir,
> > make_options)
> >                 except ConfigError as e:
> > @@ -144,7 +213,7 @@ class LinuxSourceTree(object):
> >                         return False
> >                 return self.validate_config(build_dir)
> > 
> > -       def build_reconfig(self, build_dir, make_options):
> > +       def build_reconfig(self, build_dir, defconfig,
> > make_options):
> >                 """Creates a new .config if it is not a subset of
> > the .kunitconfig."""
> >                 kconfig_path = get_kconfig_path(build_dir)
> >                 if os.path.exists(kconfig_path):
> > @@ -153,28 +222,36 @@ class LinuxSourceTree(object):
> >                         if not
> > self._kconfig.is_subset_of(existing_kconfig):
> >                                 print('Regenerating .config ...')
> >                                 os.remove(kconfig_path)
> > -                               return self.build_config(build_dir,
> > make_options)
> > +                               return self.build_config(build_dir,
> > defconfig, make_options)
> >                         else:
> >                                 return True
> >                 else:
> >                         print('Generating .config ...')
> > -                       return self.build_config(build_dir,
> > make_options)
> > +                       return self.build_config(build_dir,
> > defconfig, make_options)
> > 
> > -       def build_um_kernel(self, alltests, jobs, build_dir,
> > make_options):
> > +       def build_um_kernel(self, alltests, jobs, build_dir,
> > uml_root_dir, make_options):
> >                 if alltests:
> >                         self._ops.make_allyesconfig()
> >                 try:
> >                         self._ops.make_olddefconfig(build_dir,
> > make_options)
> > -                       self._ops.make(jobs, build_dir,
> > make_options)
> > +                       self._ops.make('make', jobs, build_dir,
> > make_options)
> > +                       if uml_root_dir:
> > +                               self._ops.make('make_modules',
> > jobs, build_dir,
> > +                                               make_options)
> > +                               self._ops.make('make_modules_instal
> > l', jobs,
> > +                                               build_dir,
> > make_options)
> >                 except (ConfigError, BuildError) as e:
> >                         logging.error(e)
> >                         return False
> >                 return self.validate_config(build_dir)
> > 
> > -       def run_kernel(self, args=[], build_dir='', timeout=None):
> > +       def run_kernel(self, args=[], build_dir='',
> > uml_root_dir=None, timeout=None):
> >                 args.extend(['mem=1G'])
> > +               if uml_root_dir:
> > +                       args.extend(['root=/dev/root',
> > 'rootfstype=hostfs',
> > +                                    'rootflags=' + uml_root_path,
> > 'umid=kunitid'])
> >                 outfile = 'test.log'
> > -               self._ops.linux_bin(args, timeout, build_dir,
> > outfile)
> > +               self._ops.linux_bin(args, timeout, build_dir,
> > uml_root_dir, outfile)
> >                 subprocess.call(['stty', 'sane'])
> >                 with open(outfile, 'r') as file:
> >                         for line in file:
> > --
> > 2.26.2
> > 

I'll fix all comments.

Thanks for the review.

